import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

    final controllersIJ = [<AnimationController>[], <AnimationController>[]];
    final flexFractionsIJ = [<int>[], <int>[]];

    for (var i = 0; i < 2; i++) {
      for (var j = 0; j < numCol; j++) {
        final controller = useAnimationController(
          duration: const Duration(milliseconds: 500),
        );
        final animation =
            CurvedAnimation(parent: controller, curve: Curves.easeInOut);
        final flex = useAnimation(animation);

        controllersIJ[i].add(controller);
        flexFractionsIJ[i].add(((flex + 1) * 1000000).floor());
      }
    }

    final controllersI = controllersIJ[0];
    final controllersJ = controllersIJ[1];
    final flexFractionsI = flexFractionsIJ[0];
    final flexFractionsJ = flexFractionsIJ[1];

    void onFocus(int i, int j) {
      if (jFocused.value != null) {
        controllersJ[jFocused.value!].reverse();
      }
      if (iFocused.value != null) {
        controllersI[iFocused.value!].reverse();
      }
      iFocused.value = i;
      jFocused.value = j;
      controllersI[i].forward();
      controllersJ[j].forward();
    }

    return Column(
      children: [
        for (var i = 0; i < numRow; i++)
          Row(
            children: [
              for (var j = 0; j < numCol; j++)
                children[i * numCol + j]
                    .gestures(
                      onTap: () => onFocus(i, j),
                    )
                    .mouseRegion(onEnter: (_) => onFocus(i, j))
                    .expanded(
                      flex: flexFractionsJ[j],
                    )
            ],
          ).expanded(
            flex: flexFractionsI[i],
          )
      ],
    );
  }
}
