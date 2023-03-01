import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../contents/skill.dart';
import '../contents/work.dart';
import '../styles.dart';

class Skill extends HookWidget {
  Skill({super.key, required this.path, this.showDetail = false}) {
    contentFuture = SkillContent.fromPath(path);
    workContentsFuture = (() async {
      final works = (await contentFuture).works;
      final workContents = <WorkContent>[];
      for (final workPath in works) {
        workContents.add(await WorkContent.fromPath(workPath));
      }
      return workContents;
    })();
  }

  final bool showDetail;
  final String path;
  late final Future<SkillContent> contentFuture;
  late final Future<List<WorkContent>> workContentsFuture;

  @override
  Widget build(BuildContext context) {
    final contentSnapshot = useFuture(contentFuture);
    if (!contentSnapshot.hasData) {
      return (contentSnapshot.hasError
              ? Text(contentSnapshot.error.toString())
              : const Text('Loading').center())
          .border(all: 1)
          .decorated(color: Colors.white);
    }
    final content = contentSnapshot.data!;

    final workContentsSnapshot = useFuture(workContentsFuture);
    if (!workContentsSnapshot.hasData) {
      return (workContentsSnapshot.hasError
              ? Text(workContentsSnapshot.error.toString())
              : const Text('Loading').center())
          .border(all: 1)
          .decorated(color: Colors.white);
    }
    final workContents = workContentsSnapshot.data!;

    Widget widget;
    if (showDetail) {
      widget = Column(
        children: [
          Row(
            children: [
              Image(
                image: contentSnapshot.data!.icon,
                filterQuality: FilterQuality.medium,
                height: 32,
              ).padding(right: 12),
              ColoredText(
                content.name,
                color: content.iconColor,
                style: heading3,
              ),
            ],
          ).padding(top: 18, left: 18, bottom: 12),
          ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final workContent in workContents)
                Column(
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
                ),
            ],
          ).expanded(),
        ],
      );
    } else {
      widget = Column(
        children: [
          Image(
            image: contentSnapshot.data!.icon,
            filterQuality: FilterQuality.medium,
            height: 32,
          ).padding(bottom: 12),
          ColoredText(
            content.name,
            color: content.iconColor,
            style: label1,
          ),
        ],
      ).fittedBox(fit: BoxFit.scaleDown).center();
    }
    return widget.border(all: 1).decorated(color: Colors.white);
  }
}
