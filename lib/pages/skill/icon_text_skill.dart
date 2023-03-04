import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../components/horizontal_list_view.dart';
import '../../contents/skill.dart';
import '../../contents/work.dart';
import '../../styles.dart';

class IconTextSkill extends HookWidget {
  const IconTextSkill({
    super.key,
    required this.path,
    required this.showDetail,
    required this.onClose,
  });

  final String path;
  final bool showDetail;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    final content = SkillContent.fromPath(path);
    final workPaths = content.works;

    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Image(
                  image: content.icon,
                  filterQuality: FilterQuality.medium,
                  height: 32,
                ).padding(right: 12),
                ColoredText(
                  content.name,
                  color: content.iconColor,
                  style: heading3,
                ).padding(right: 16),
              ],
            )
                .fittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                )
                .expanded(),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(4)),
              ),
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: const Icon(Icons.close_rounded),
            )
                .gestures(onTap: onClose)
                .mouseRegion(cursor: SystemMouseCursors.click),
          ],
        ).padding(top: 18, horizontal: 18, bottom: 12),
        HorizontalListView(
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
        ).expanded(),
      ],
    ).border(all: 1);
  }
}
