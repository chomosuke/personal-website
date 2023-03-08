import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class DiscordInception extends HookWidget {
  const DiscordInception({
    super.key,
    required this.childFactory,
  });

  final Widget Function(int) childFactory;

  @override
  Widget build(BuildContext context) {
    Widget rec(int layer, num length, BoxConstraints constraints) {
      final startingIndex = layer * 3;
      final cs = [
        childFactory(startingIndex),
        childFactory(startingIndex + 1),
        childFactory(startingIndex + 2),
      ];
      for (var i = 0; i < cs.length; i++) {
        cs[i] = cs[i]
            .width(constraints.maxWidth / 2)
            .height(constraints.maxHeight / 2)
            .fittedBox();
      }
      if (length < 8) {
        return cs[0];
      } else {
        return Column(
          children: [
            Row(
              children: [
                cs[0].expanded(),
                cs[1].expanded(),
              ],
            ).expanded(),
            Row(
              children: [
                cs[2].expanded(),
                rec(layer + 1, length / 2, constraints).expanded(),
              ],
            ).expanded(),
          ],
        );
      }
    }

    final toTargetAnimationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final toTargetAnimation = useAnimation(
      CurvedAnimation(
        parent: toTargetAnimationController,
        curve: Curves.easeOut,
      ),
    );
    final residualScroll = useRef(0.0);

    final scale = useState(1.0);
    final initLayer = useState(0);
    double calcScale() =>
        scale.value * pow(2, residualScroll.value * toTargetAnimation);
    void updateInitLayer() {
      while (calcScale() > 2) {
        scale.value /= 2;
        initLayer.value += 1;
      }
      while (calcScale() < 1) {
        scale.value *= 2;
        initLayer.value -= 1;
      }
    }

    int getInitLayer() {
      updateInitLayer();
      return initLayer.value;
    }

    void setScale(double value) {
      scale.value = value;
    }

    double getScale() {
      updateInitLayer();
      return calcScale();
    }

    return Listener(
      onPointerSignal: (signal) {
        if (signal is PointerScrollEvent) {
          // for every scroll event: animationController is resetted and the
          // residualScroll & scale is updated.
          final delta = signal.scrollDelta.dy / 500;
          setScale(getScale());
          residualScroll
            ..value *= 1 - toTargetAnimation
            ..value += delta;
          if (!(toTargetAnimationController.status == AnimationStatus.forward &&
              toTargetAnimation == 0)) {
            toTargetAnimationController.forward(from: 0);
          }
        }
      },
      child: GestureDetector(
        onPanUpdate: (details) {
          final delta = -(details.delta.dx + details.delta.dy) / 150;
          setScale(getScale() * pow(2, delta));
          residualScroll.value = 0;
        },
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraint) => rec(
            getInitLayer(),
            max(constraint.maxWidth, constraint.maxHeight) * getScale(),
            constraint,
          ).scale(all: getScale(), alignment: Alignment.bottomRight).clipRect(),
        ),
      ),
    );
  }
}
