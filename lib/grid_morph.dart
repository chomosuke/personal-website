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
                  },
                ).expanded(
                  flex: j == jFocused.value ? 2 : 1,
                )
            ],
          ).expanded(
            flex: i == iFocused.value ? 2 : 1,
          )
      ],
    );
  }
}
