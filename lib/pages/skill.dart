import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../components/popup_button.dart';
import '../contents/skill.dart';
import '../contents/work.dart';
import '../styles.dart';

enum SkillState {
  button,
  iconText,
  detailed,
}

class Skill extends HookWidget {
  const Skill({
    super.key,
    required this.path,
    required this.state,
    this.onClose,
    this.onClick,
  });

  final SkillState state;
  final String path;
  final void Function()? onClose;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final content = SkillContent.fromPath(path);
    final worksScrollController = useScrollController();
    if (state == SkillState.detailed) {
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
          Listener(
            onPointerSignal: (signal) {
              if (signal is PointerScrollEvent) {
                final position = worksScrollController.position;
                final newOffset = max(
                  0.0,
                  min(
                    position.maxScrollExtent,
                    position.pixels + signal.scrollDelta.dy / 5,
                  ),
                );
                worksScrollController.jumpTo(newOffset);
              }
            },
            child: ListView(
              controller: worksScrollController,
              scrollDirection: Axis.horizontal,
              children: [
                for (final workPath in content.works)
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
            ),
          ).expanded(),
        ],
      ).border(all: 1);
    } else if (state == SkillState.iconText) {
      return Column(
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
      ).fittedBox(fit: BoxFit.scaleDown).center().border(all: 1);
    } else {
      return PopupButton(
        text: content.name,
        color: content.iconColor,
        onClick: onClick ?? () {},
      );
    }
  }
}
