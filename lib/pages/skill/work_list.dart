import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../components/horizontal_list_view.dart';
import '../../contents/work.dart';
import '../../styles.dart';

class WorkList extends HookWidget {
  const WorkList({super.key, required this.workPaths, this.animation = 1});
  final double animation;
  final List<String> workPaths;
  @override
  Widget build(BuildContext context) {
    const padding = 8.0;
    const borderThickness = 2.0;

    final seeAllProjectAnimation = max(0.0, (animation - 0.5) * 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        HorizontalListView(
          children: [
            for (var i = 0; i < workPaths.length; i++)
              () {
                final workContent = WorkContent.fromPath(workPaths[i]);
                return Column(
                  children: [
                    Image(image: workContent.screenshot, fit: BoxFit.cover)
                        .expanded(flex: 100),
                    const ColoredBox(
                      color: Colors.black,
                      child: SizedBox.expand(),
                    ).constrained(height: 2),
                    ColoredText(
                      workContent.shortName,
                      color: primary03,
                      style: heading5,
                    ).padding(all: 8).fittedBox().expanded(flex: 24),
                  ],
                )
                    .gestures(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        context.go('/${workPaths[i]}');
                      },
                    )
                    .mouseRegion(cursor: SystemMouseCursors.click)
                    .aspectRatio(aspectRatio: 116 / 124)
                    .padding(all: borderThickness)
                    .border(all: borderThickness)
                    .padding(
                      left: i == 0 ? 0 : padding,
                      right: i == workPaths.length - 1 ? 0 : padding,
                    );
              }(),
          ],
        ).fractionallySizedBox(widthFactor: animation).expanded(),
        SizedBox.square(dimension: 12 * seeAllProjectAnimation),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('See all projects', style: heading5Underline)
                .mouseRegion(cursor: SystemMouseCursors.click),
            const Icon(
              PhosphorIcons.arrowLineUpRight,
              size: 16,
            ).mouseRegion(cursor: SystemMouseCursors.click),
          ],
        )
            .gestures(
              onTap: () {
                context.go('/works');
              },
            )
            .fittedBox(fit: BoxFit.scaleDown)
            .height(16 * seeAllProjectAnimation),
        SizedBox.square(dimension: 12 * seeAllProjectAnimation),
      ],
    ).padding(all: padding);
  }
}
