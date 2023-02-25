import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../contents/skill.dart';
import '../text_styles.dart';

class Skill extends HookWidget {
  Skill({super.key, required this.path, this.showDetail = false})
      : contentFuture = SkillContent.fromPath(path);

  final bool showDetail;
  final String path;
  final Future<SkillContent> contentFuture;

  @override
  Widget build(BuildContext context) {
    final content = useFuture(contentFuture);
    return (content.hasData
            ? Column(
                children: [
                  Image(
                    image: content.data!.icon,
                    filterQuality: FilterQuality.medium,
                    height: 32,
                  ).padding(bottom: 12),
                  ColoredText(
                    content.data!.name,
                    color: content.data!.iconColor,
                    style: label1.textStyle,
                    colorHeight: label1.colorHeight,
                    topOffset: label1.topOffset,
                  ),
                ],
              ).fittedBox(fit: BoxFit.scaleDown).center()
            : content.hasError
                ? Text(content.error.toString())
                : const Text('Loading').center())
        .border(all: 1)
        .decorated(color: Colors.white);
  }
}
