import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      PhosphorIcons.arrowElbowUpLeftBold,
                      size: 32,
                    ),
                    onPressed: () => context.go('/works'),
                  ),
                  Row(
                    children: [
                      ColoredText(
                        content.name,
                        color: primary03,
                        style: heading2,
                      ).padding(left: 4),
                      const Spacer(),
                      Text(content.time, style: heading2.textStyle),
                    ],
                  ).padding(top: 6.8).expanded(),
                ],
              ).padding(horizontal: 64, top: 24, bottom: 12),
              const ColoredBox(color: Colors.black)
                  .height(2)
                  .padding(left: 102, right: 64, bottom: 16),
              Text(content.summary, style: heading4.textStyle)
                  .padding(left: 102, bottom: 24),
              WorkContentDisplay(path: path),
            ],
          ).scrollable()
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
