import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/colored_text.dart';
import '../contents/work.dart';
import '../styles.dart';

class Work extends HookWidget {
  const Work({super.key, required this.path, this.showDetail = false});

  final String path;
  final bool showDetail;

  @override
  Widget build(BuildContext context) {
    final content = WorkContent.fromPath(path);
    return showDetail
        ? RichText(
            text: TextSpan(
              children: [
                for (final point in content.description)
                  for (final spanContent in point)
                    if (spanContent is TextSpanContent)
                      TextSpan(text: spanContent.text)
                    else if (spanContent is LinkSpanContent)
                      TextSpan(
                        text: spanContent.path,
                        style: const TextStyle(color: Colors.red),
                      )
                    else if (spanContent is ExternLinkSpanContent)
                      TextSpan(
                        text: spanContent.externLink,
                        style: const TextStyle(color: Colors.blue),
                      )
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: content.screenshot,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ).expanded(),
              ColoredText(
                content.name,
                style: heading4,
                color: primary03,
              )
                  .padding(top: 12, horizontal: 12)
                  .fittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topLeft,
                  )
                  .height(72)
                  .border(top: 1),
            ],
          ).border(all: 1).decorated(color: Colors.white);
  }
}
