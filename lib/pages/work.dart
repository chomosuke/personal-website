import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../contents/work.dart';
import '../text_styles.dart';

class Work extends HookWidget {
  Work({super.key, required this.path})
      : contentFuture = WorkContent.fromPath(path);

  final String path;
  final Future<WorkContent> contentFuture;

  @override
  Widget build(BuildContext context) {
    final content = useFuture(contentFuture);
    return (content.hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(
                    image: content.data!.screenshot,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  ).expanded(),
                  ColoredText(
                    content.data!.name,
                    style: heading4,
                    color: const Color(0xCCFFB388),
                  )
                      .padding(top: 20, left: 20)
                      .alignment(Alignment.topLeft)
                      .height(72)
                      .border(top: 1),
                ],
              )
            : const Text('loading').center())
        .border(all: 1)
        .decorated(color: Colors.white);
  }
}
