import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class GridMorph extends HookWidget {
  const GridMorph({
    super.key,
    required this.childrenCount,
    required this.childFactory,
    this.maxClicked = 3,
  });

  final Widget Function(
    BuildContext context,
    int index,
    bool clicked,
    bool hovered,
  ) childFactory;
  final int childrenCount;
  final int maxClicked;

  @override
  Widget build(BuildContext context) {
    final numCol = sqrt(childrenCount).ceil();
    final numRow = (childrenCount / numCol).ceil();

    final clicked = useState<ListQueue<_IJ>>(ListQueue());
    final hovered = useState<_IJ?>(null);

    final hoverControllersIJ = [
      <AnimationController>[],
      <AnimationController>[]
    ];
    final clickControllersIJ = [
      <AnimationController>[],
      <AnimationController>[]
    ];
    final flexFractionsIJ = [<int>[], <int>[]];

    for (var i = 0; i < 2; i++) {
      for (var j = 0; j < (i == 0 ? numRow : numCol); j++) {
        final hoverController = useAnimationController(
          duration: const Duration(milliseconds: 500),
        );
        final clickController = useAnimationController(
          duration: const Duration(milliseconds: 500),
        );
        final hoverAnimation = CurvedAnimation(
          parent: hoverController,
          curve: Curves.easeInOut,
        );
        final clickAnimation = CurvedAnimation(
          parent: clickController,
          curve: Curves.easeInOut,
        );
        final flex = 0.1 * useAnimation(hoverAnimation) +
            2 * useAnimation(clickAnimation);

        hoverControllersIJ[i].add(hoverController);
        clickControllersIJ[i].add(clickController);
        flexFractionsIJ[i].add(((flex + 1) * 1000000).round());
      }
    }

    final hoverControllersI = hoverControllersIJ[0];
    final hoverControllersJ = hoverControllersIJ[1];
    final clickControllersI = clickControllersIJ[0];
    final clickControllersJ = clickControllersIJ[1];
    final flexFractionsI = flexFractionsIJ[0];
    final flexFractionsJ = flexFractionsIJ[1];

    void updateClickController() {
      final iClicked = List.filled(numRow, false);
      final jClicked = List.filled(numCol, false);
      for (final ij in clicked.value) {
        iClicked[ij.i] = true;
        jClicked[ij.j] = true;
      }
      for (var i = 0; i < numRow; i++) {
        if (iClicked[i]) {
          clickControllersI[i].forward();
        } else {
          clickControllersI[i].reverse();
        }
      }
      for (var j = 0; j < numCol; j++) {
        if (jClicked[j]) {
          clickControllersJ[j].forward();
        } else {
          clickControllersJ[j].reverse();
        }
      }
    }

    void onUnclick(_IJ ij) {
      clicked.value.remove(ij);
      updateClickController();
    }

    void onClick(_IJ ij) {
      if (!clicked.value.contains(ij)) {
        clicked.value.addLast(ij);
      }
      while (clicked.value.length > maxClicked) {
        clicked.value.removeFirst();
      }
      updateClickController();
    }

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

    return Column(
      children: [
        for (var i = 0; i < numRow; i++)
          Row(
            children: [
              for (var j = 0; j < numCol; j++)
                (clicked.value.contains(_IJ(i, j))
                        ? childFactory(
                            context,
                            i * numCol + j,
                            true,
                            hovered.value == _IJ(i, j),
                          ).gestures(
                            onTap: () => onUnclick(_IJ(i, j)),
                          )
                        : childFactory(
                            context,
                            i * numCol + j,
                            false,
                            hovered.value == _IJ(i, j),
                          ).gestures(
                            onTap: () => onClick(_IJ(i, j)),
                          ))
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
