import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class DiscordInception extends HookWidget {
  const DiscordInception({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    Widget rec(int layer, num length, BoxConstraints constraints) {
      final startingIndex = layer * 3;
      final cs = [
        children[startingIndex % children.length],
        children[(startingIndex + 1) % children.length],
        children[(startingIndex + 2) % children.length],
      ];
      for (var i = 0; i < cs.length; i++) {
        cs[i] = cs[i]
            .width(constraints.maxWidth / 2)
            .height(constraints.maxHeight / 2)
            .fittedBox();
      }
      if (length < 20) {
        return cs[0];
      } else {
        return Column(
          children: [
            Row(children: [cs[0].expanded(), cs[1].expanded()]).expanded(),
            Row(
              children: [
                cs[2].expanded(),
                rec(layer + 1, length / 2, constraints).expanded()
              ],
            ).expanded(),
          ],
        );
      }
    }

    final scale = useState(1.0);
    final initLayer = useState(0);
    void scroll(double delta) {
      var newScale = scale.value * pow(2, delta);
      while (newScale > 4) {
        newScale /= 2;
        initLayer.value += 1;
      }
      while (newScale < 2) {
        newScale *= 2;
        initLayer.value -= 1;
      }
      scale.value = newScale;
    }

    return Listener(
      onPointerSignal: (signal) {
        if (signal is PointerScrollEvent) {
          scroll(signal.scrollDelta.dy / 500);
        }
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          scroll(-(details.delta.dx + details.delta.dy) / 100);
        },
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraint) => rec(
            initLayer.value,
            max(constraint.maxWidth, constraint.maxHeight) * scale.value,
            constraint,
          )
              .scale(all: scale.value, alignment: Alignment.bottomRight)
              .clipRect(),
        ),
      ),
    );
  }
}
