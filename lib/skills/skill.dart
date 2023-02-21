import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../contents/skill.dart';

class Skill extends HookWidget {
  const Skill({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final content = useFuture(SkillContent.fromPath(path));
    return (content.hasData
            ? Row(
                children: [
                  Image(
                    image: content.data!.icon,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  Text(content.data!.name),
                ],
              ).center()
            : content.hasError
                ? Text(content.error.toString())
                : const Text('Loading').center())
        .border(all: 1);
  }
}
