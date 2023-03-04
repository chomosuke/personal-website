import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class GridMorph extends HookWidget {
  const GridMorph({
    super.key,
    required this.childrenCount,
    required this.childFactory,
    required this.animationDuration,
  });

  final GridMorphChild Function(
    BuildContext context,
    int index,
    bool hovered,
  ) childFactory;
  final int childrenCount;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final numCol = sqrt(childrenCount).ceil();
    final numRow = (childrenCount / numCol).ceil();

    // initialize controllers
    final hoverControllersIJ = [
      <AnimationController>[],
      <AnimationController>[]
    ];
    final selectControllersIJ = [
      <AnimationController>[],
      <AnimationController>[]
    ];
    final flexFractionsIJ = [<int>[], <int>[]];

    for (var i = 0; i < 2; i++) {
      for (var j = 0; j < (i == 0 ? numRow : numCol); j++) {
        final hoverController = useAnimationController(
          duration: animationDuration,
        );
        final selectController = useAnimationController(
          duration: animationDuration,
        );
        final hoverAnimation = CurvedAnimation(
          parent: hoverController,
          curve: Curves.easeInOut,
        );
        final selectAnimation = CurvedAnimation(
          parent: selectController,
          curve: Curves.easeInOut,
        );
        final flex = 0.1 * useAnimation(hoverAnimation) +
            2 * useAnimation(selectAnimation);

        hoverControllersIJ[i].add(hoverController);
        selectControllersIJ[i].add(selectController);
        flexFractionsIJ[i].add(((flex + 1) * 1000000).round());
      }
    }

    final hoverControllersI = hoverControllersIJ[0];
    final hoverControllersJ = hoverControllersIJ[1];
    final selectControllersI = selectControllersIJ[0];
    final selectControllersJ = selectControllersIJ[1];
    final flexFractionsI = flexFractionsIJ[0];
    final flexFractionsJ = flexFractionsIJ[1];

    // hover state
    final hovered = useState<_IJ?>(null);
    void onHover(_IJ? ij) {
      if (hovered.value != null) {
        hoverControllersI[hovered.value!.i].reverse();
        hoverControllersJ[hovered.value!.j].reverse();
      }
      hovered.value = ij;
      if (hovered.value != null) {
        hoverControllersI[hovered.value!.i].forward();
        hoverControllersJ[hovered.value!.j].forward();
      }
    }

    // get all children and their status
    final children = <GridMorphChild>[];
    for (var i = 0; i < numRow; i++) {
      for (var j = 0; j < numCol; j++) {
        children.add(
          childFactory(context, i * numCol + j, hovered.value == _IJ(i, j)),
        );
      }
    }

    // animate upon prop change
    final iSelected = List.filled(numRow, false);
    final jSelected = List.filled(numCol, false);
    for (var i = 0; i < numRow; i++) {
      for (var j = 0; j < numCol; j++) {
        if (children[i * numCol + j].selected) {
          iSelected[i] = true;
          jSelected[j] = true;
        }
      }
    }
    for (var i = 0; i < numRow; i++) {
      if (iSelected[i]) {
          selectControllersI[i].forward();
      } else {
          selectControllersI[i].reverse();
      }
    }
    for (var j = 0; j < numCol; j++) {
      if (jSelected[j]) {
          selectControllersJ[j].forward();
      } else {
          selectControllersJ[j].reverse();
      }
    }

    return Column(
      children: [
        for (var i = 0; i < numRow; i++)
          Row(
            children: [
              for (var j = 0; j < numCol; j++)
                children[i * numCol + j]
                    .widget
                    .mouseRegion(
                      onEnter: (_) => onHover(_IJ(i, j)),
                      onExit: (_) => onHover(null),
                    )
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

@immutable
class _IJ {
  const _IJ(this.i, this.j);
  final int i;
  final int j;

  @override
  bool operator ==(Object other) {
    return other is _IJ && i == other.i && j == other.j;
  }

  @override
  int get hashCode => i + j;
}

@immutable
class GridMorphChild {
  const GridMorphChild({
    required this.widget,
    required this.selected,
  });
  final Widget widget;
  final bool selected;
}
