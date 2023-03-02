import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../contents/skill.dart';
import '../contents/work.dart';
import '../styles.dart';

class Skill extends HookWidget {
  const Skill({
    super.key,
    required this.path,
    this.showDetail = false,
    required this.onClose,
  });

  final bool showDetail;
  final String path;
  final void Function() onClose;

  @override
  Widget build(BuildContext context) {
    final content = SkillContent.fromPath(path);
    final workContents = <WorkContent>[];
    final works = content.works;
    for (final workPath in works) {
      workContents.add(WorkContent.fromPath(workPath));
    }

    Widget widget;
    if (showDetail) {
      widget = Column(
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
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: const Icon(Icons.close_rounded),
              ).gestures(onTap: onClose),
            ],
          ).padding(top: 18, horizontal: 18, bottom: 12),
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
            image: content.icon,
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
