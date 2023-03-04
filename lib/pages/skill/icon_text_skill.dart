import 'dart:math';

import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../contents/skill.dart';
import '../../styles.dart';
import 'work_list.dart';

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
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );

    return animation == 0
        ? Column(
            children: [
              Image(
                image: content.icon,
                filterQuality: FilterQuality.medium,
                height: 32,
              ).padding(bottom: 12),
              ColoredText(
                content.name,
                color: content.iconColor,
                style: heading3,
              ).fittedBox(fit: BoxFit.fitHeight).height(20),
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
              Row(
                children: [
                  if (animation < 1)
                    Spacer(flex: (1000000 * (1 - animation)).ceil()),
                  CustomBoxy(
                    delegate: _IconTextDelegate(animation),
                    children: [
                      Image(
                        image: content.icon,
                        filterQuality: FilterQuality.medium,
                        height: 32,
                      ).padding(
                        bottom: 12 * (1 - animation),
                        right: 12 * animation,
                      ),
                      ColoredText(
                        content.name,
                        color: content.iconColor,
                        style: heading3,
                      )
                          .fittedBox(fit: BoxFit.fitHeight)
                          .height(20 + 18 * animation)
                          .padding(right: 16 * animation),
                    ],
                  ).fittedBox(
                    fit: BoxFit.scaleDown,
                  ),
                  const Spacer(flex: 1000000),
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
              if (animation < 1)
                Spacer(flex: (1000000 * (1 - animation)).ceil()),
              WorkList(workPaths: content.works)
                  .expanded(flex: (1000000 * animation).ceil()),
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
    final child1 = children.first;
    final child2 = children.last;

    final child1Size = child1.layout(constraints);
    final child2Size = child2.layout(constraints);

    final child1PosCol = Offset(
      max(0, child2Size.width - child1Size.width) / 2,
      0,
    );
    final child2PosCol = Offset(
      max(0, child1Size.width - child2Size.width) / 2,
      child1Size.height,
    );

    final child1PosRow = Offset(
      0,
      max(0, child2Size.height - child1Size.height) / 2,
    );
    final child2PosRow = Offset(
      child1Size.width,
      max(0, child1Size.height - child2Size.height) / 2,
    );

    final child1Pos = child1PosRow * rowness + child1PosCol * (1 - rowness);
    final child2Pos = child2PosRow * rowness + child2PosCol * (1 - rowness);

    child1.position(child1Pos);
    child2.position(child2Pos);

    return Size(
      max(child2Pos.dx + child2Size.width, child1Pos.dx + child1Size.width),
      max(child2Pos.dy + child2Size.height, child1Pos.dy + child1Size.height),
    );
  }
}
