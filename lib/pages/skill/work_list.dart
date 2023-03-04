import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../components/horizontal_list_view.dart';
import '../../contents/work.dart';
import '../../styles.dart';

class WorkList extends HookWidget {
  const WorkList({super.key, required this.workPaths});

  final List<String> workPaths;
  @override
  Widget build(BuildContext context) {
    const padding = 8.0;
    const borderThickness = 2.0;
    return HorizontalListView(
      children: [
        for (var i = 0; i < workPaths.length; i++)
          () {
            final workContent = WorkContent.fromPath(workPaths[i]);
            return Column(
              children: [
                Image(image: workContent.screenshot, fit: BoxFit.cover)
                    .aspectRatio(aspectRatio: 116 / 100)
                    .padding(bottom: borderThickness)
                    .border(bottom: borderThickness)
                    .expanded(),
                ColoredText(
                  workContent.name,
                  color: primary03,
                  style: heading5,
                )
              ],
            )
                .gestures(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.go('/${workPaths[i]}');
                  },
                )
                .mouseRegion(cursor: SystemMouseCursors.click)
                .padding(all: borderThickness)
                .border(all: borderThickness)
                .padding(
                  vertical: 2 * padding,
                  left: i == 0 ? padding * 2 : padding,
                  right: i == workPaths.length - 1 ? padding * 2 : padding,
                );
          }(),
      ],
    );
  }
}
