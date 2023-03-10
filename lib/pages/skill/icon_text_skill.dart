import 'dart:math';

import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../contents/skill.dart';
import '../../styles.dart';
import 'button_skill.dart';
import 'contract_button.dart';
import 'skill_content.dart';

class IconTextSkill extends HookWidget {
  const IconTextSkill({
    super.key,
    required this.path,
    required this.showDetail,
    required this.animationDuration,
    this.onClose,
    this.onClick,
  });

  final String path;
  final bool showDetail;
  final Duration animationDuration;
  final void Function()? onClose;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    final content = SkillContent.fromPath(path);

    final controller = useAnimationController(duration: animationDuration);
    if (showDetail) {
      controller.forward();
    } else {
      controller.reverse();
    }

    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    return animation == 0
        ? Column(
            children: [
              getIcon(content.iconPath, height: 32).padding(bottom: 12),
              ColoredText(
                content.name,
                color: content.iconColor,
                style: heading3,
              )
                  .padding(horizontal: 24)
                  .fittedBox(fit: BoxFit.fitHeight)
                  .height(20),
            ],
          )
            .fittedBox(fit: BoxFit.scaleDown)
            .center()
            .border(all: 1)
            .gestures(onTap: onClick, behavior: HitTestBehavior.opaque)
        : Column(
            children: [
              if (animation < 1)
                Spacer(flex: (1000000 * (1 - animation)).ceil()),
              CustomBoxy(
                delegate: _TitleDelegate(1 - animation),
                children: [
                  CustomBoxy(
                    delegate: _IconTextDelegate(animation),
                    children: [
                      getIcon(content.iconPath, height: 32).padding(
                        bottom: 12 * (1 - animation),
                        right: 12 * animation,
                      ),
                      ColoredText(
                        content.name,
                        color: content.iconColor,
                        style: heading3,
                      )
                          .padding(horizontal: 24 * (1 - animation))
                          .fittedBox(fit: BoxFit.fitHeight)
                          .height(20 + 18 * animation)
                          .padding(right: 16 * animation),
                    ],
                  ).fittedBox(fit: BoxFit.scaleDown),
                  ContractButton(onPressed: onClose, animation: animation),
                ],
              ).padding(
                top: 18 * animation,
                horizontal: 18 * animation,
              ),
              if (animation < 1)
                Spacer(flex: (500000 * (1 - animation)).ceil()),
              SkillContentDisplay(content: content, animation: animation)
                  .expanded(flex: (1000000 * animation).ceil()),
              if (animation < 1)
                Spacer(flex: (500000 * (1 - animation)).ceil()),
            ],
          ).border(all: 1);
  }
}

class _IconTextDelegate extends BoxyDelegate {
  _IconTextDelegate(this.rowness);
  final double rowness;
  @override
  Size layout() {
    // assume only two children
    final icon = children.first;
    final text = children.last;

    final iconSize = icon.layout(constraints);
    final textSize = text.layout(constraints);

    final iconPosCol = Offset(
      max(0, textSize.width - iconSize.width) / 2,
      0,
    );
    final textPosCol = Offset(
      max(0, iconSize.width - textSize.width) / 2,
      iconSize.height,
    );

    final iconPosRow = Offset(
      0,
      max(0, textSize.height - iconSize.height) / 2,
    );
    final textPosRow = Offset(
      iconSize.width,
      max(0, iconSize.height - textSize.height) / 2,
    );

    final iconPos = iconPosRow * rowness + iconPosCol * (1 - rowness);
    final textPos = textPosRow * rowness + textPosCol * (1 - rowness);

    icon.position(iconPos);
    text.position(textPos);

    return Size(
      max(textPos.dx + textSize.width, iconPos.dx + iconSize.width),
      max(textPos.dy + textSize.height, iconPos.dy + iconSize.height),
    );
  }
}

class _TitleDelegate extends BoxyDelegate {
  _TitleDelegate(this.centerness);
  final double centerness;
  @override
  Size layout() {
    final iconText = children[0];
    final closeButton = children[1];

    final closeButtonSize = closeButton.layout(constraints);
    final closeButtonStart = constraints.maxWidth - closeButtonSize.width;
    final iconTextSize = iconText.layout(
      BoxConstraints(maxWidth: closeButtonStart),
    );

    final iconTextPos = Offset(
      (closeButtonStart - iconTextSize.width) / 2 * centerness,
      max(0, closeButtonSize.height - iconTextSize.height) / 2,
    );
    final closeButtonPos = Offset(
      closeButtonStart,
      max(0, iconTextSize.height - closeButtonSize.height) / 2,
    );

    iconText.position(iconTextPos);
    closeButton.position(closeButtonPos);

    return Size(
      max(
        closeButtonPos.dx + closeButtonSize.width,
        iconTextPos.dx + iconTextSize.width,
      ),
      max(
        closeButtonPos.dy + closeButtonSize.height,
        iconTextPos.dy + iconTextSize.height,
      ),
    );
  }
}
