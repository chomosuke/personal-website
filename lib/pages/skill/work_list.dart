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
    return HorizontalListView(
      children: [
        for (final workPath in workPaths)
          () {
            final workContent = WorkContent.fromPath(workPath);
            return Column(
              children: [
                Image(image: workContent.screenshot, fit: BoxFit.cover)
                    .aspectRatio(aspectRatio: 116 / 100)
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
                    context.go('/$workPath');
                  },
                )
                .mouseRegion(cursor: SystemMouseCursors.click)
                .border(all: 1);
          }(),
      ],
    );
  }
}
