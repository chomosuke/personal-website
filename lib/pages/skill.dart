import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../contents/skill.dart';

class Skill extends HookWidget {
  Skill({super.key, required this.path})
      : contentFuture = SkillContent.fromPath(path);

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
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Text(content.data!.name),
                ],
              ).fittedBox(fit: BoxFit.scaleDown).center()
            : content.hasError
                ? Text(content.error.toString())
                : const Text('Loading').center())
        .border(all: 1)
        .decorated(color: Colors.white);
  }
}
