import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fraction/fraction.dart';
import 'package:styled_widget/styled_widget.dart';

class GridMorph extends HookWidget {
  const GridMorph({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final numCol = sqrt(children.length).floor();
    final numRow = (children.length / numCol).ceil();

    final iFocused = useState<int?>(null);
    final jFocused = useState<int?>(null);
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final animation = CurvedAnimation(parent: controller, curve: Curves.ease);
    final flex = useAnimation(animation);

    final flexFraction = Fraction.fromDouble(flex + 1).reduce();
    return Column(
      children: [
        for (var i = 0; i < numRow; i++)
          Row(
            children: [
              for (var j = 0; j < numCol; j++)
                children[i * numCol + j].gestures(
                  onTap: () {
                    iFocused.value = i;
                    jFocused.value = j;
                    controller.forward(from: 0);
                  },
                ).expanded(
                  flex: j == jFocused.value ? flexFraction[0] : flexFraction[1],
                )
            ],
          ).expanded(
            flex: i == iFocused.value ? flexFraction[0] : flexFraction[1],
          )
      ],
    );
  }
}
