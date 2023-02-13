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
    Widget rec(int layer, num length) {
      final startingIndex = layer * 3;
      final cs = [
        children[startingIndex % children.length],
        children[(startingIndex + 1) % children.length],
        children[(startingIndex + 2) % children.length],
      ];
      if (length < 2) {
        return cs[0];
      } else {
        return Column(
          children: [
            Row(children: [cs[0].expanded(), cs[1].expanded()]).expanded(),
            Row(
              children: [
                cs[2].expanded(),
                rec(layer + 1, length / 2).expanded()
              ],
            ).expanded(),
          ],
        );
      }
    }

    final scale = useState(1.0);
    final initLayer = useState(0);
    return Listener(
      onPointerSignal: (signal) {
        if (signal is PointerScrollEvent) {
          var newScale = scale.value * pow(1.001, signal.scrollDelta.dy);
          if (newScale > 3) {
            newScale /= 2;
            initLayer.value += 1;
          }
          if (newScale < 1) {
            newScale *= 2;
            initLayer.value -= 1;
          }
          scale.value = newScale;
        }
      },
      child: LayoutBuilder(
        builder: (context, constraint) => rec(
          initLayer.value,
          max(constraint.maxWidth, constraint.maxHeight) * scale.value,
        ).scale(all: scale.value, alignment: Alignment.bottomRight),
      ),
    );
  }
}
