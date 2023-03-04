import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../components/popup_button.dart';
import '../../contents/skill.dart';
import '../../styles.dart';
import 'work_list.dart';

class ButtonSkill extends HookWidget {
  const ButtonSkill({
    super.key,
    required this.path,
    required this.animation,
    required this.textHeight,
    this.onClose,
    this.onClick,
  });

  final String path;
  final double animation;
  final void Function()? onClose;
  final void Function()? onClick;
  final double textHeight;

  @override
  Widget build(BuildContext context) {
    final content = SkillContent.fromPath(path);

    return animation == 0
        ? PopupButton(
            onClick: onClick,
            color: content.iconColor,
            child: Text(content.name, style: heading3.textStyle)
                .fittedBox(fit: BoxFit.fitHeight)
                .height(textHeight + (38 - textHeight) * animation)
                .padding(horizontal: 6, vertical: 2),
          )
        : Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image(
                        image: content.icon,
                        filterQuality: FilterQuality.medium,
                        height: 32 * animation,
                      ).padding(right: 12 * animation),
                      ColoredText(
                        content.name,
                        color: Color.fromRGBO(
                          content.iconColor.red,
                          content.iconColor.green,
                          content.iconColor.blue,
                          content.iconColor.opacity * animation,
                        ),
                        style: heading3,
                      )
                          .fittedBox(fit: BoxFit.fitHeight)
                          .height(textHeight + (38 - textHeight) * animation)
                          .padding(right: 16 * animation)
                          .padding(
                            horizontal: 6 * (1 - animation),
                            vertical: 2 * (1 - animation),
                          ),
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
                    width: 32 * animation,
                    height: 32 * animation,
                    alignment: Alignment.center,
                    child: Icon(Icons.close_rounded, size: 24 * animation),
                  )
                      .gestures(onTap: onClose)
                      .mouseRegion(cursor: SystemMouseCursors.click),
                ],
              ).padding(
                top: 18 * animation,
                horizontal: 18 * animation,
                bottom: 12 * animation,
              ),
              WorkList(workPaths: content.works).expanded(),
            ],
          ).border(all: 2);
  }
}