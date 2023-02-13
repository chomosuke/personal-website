import 'dart:math';

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
  LayoutBuilder build(BuildContext context) {
    Widget rec(int layer, num length) {
      final startingIndex = layer * 3;
      final cs = [
        children[startingIndex % children.length],
        children[(startingIndex + 1) % children.length],
        children[(startingIndex + 2) % children.length],
      ];
      if (length <= 2) {
        return const SizedBox.shrink();
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

    return LayoutBuilder(
      builder: (context, constraint) =>
          rec(0, max(constraint.maxWidth, constraint.maxHeight)),
    );
  }
}
