import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../components/colored_text.dart';
import '../../components/popup_button.dart';
import '../../contents/skill.dart';
import '../../styles.dart';
import 'contract_button.dart';
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
            border: 1.2,
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
                      getIcon(content.iconPath, height: 32 * animation)
                          .padding(right: 12 * animation),
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
                  ContractButton(onPressed: onClose, animation: animation),
                ],
              ).padding(
                top: 18 * animation,
                horizontal: 18 * animation,
                bottom: 12 * animation,
              ),
              WorkList(workPaths: content.works, animation: animation)
                  .expanded(),
            ],
          ).border(all: 1.2 + 0.8 * animation);
  }
}

Widget getIcon(String path, {required double height}) {
  return path.contains('svg')
      ? SvgPicture(AssetBytesLoader(path), height: height)
      : Image.asset(path, filterQuality: FilterQuality.medium, height: height);
}
