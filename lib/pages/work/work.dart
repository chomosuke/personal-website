import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/colored_text.dart';
import '../../contents/work.dart';
import '../../styles.dart';
import 'work_content.dart';

class Work extends HookWidget {
  const Work({super.key, required this.path, this.showDetail = false});

  final String path;
  final bool showDetail;

  @override
  Widget build(BuildContext context) {
    final content = WorkContent.fromPath(path);
    return showDetail
        ? WorkContentDisplay(path: path)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image(
                image: content.screenshot,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ).expanded(),
              ColoredText(
                content.shortName,
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
          )
            .border(all: 1)
            .gestures(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.go('/$path');
              },
            )
            .mouseRegion(cursor: SystemMouseCursors.click);
  }
}
