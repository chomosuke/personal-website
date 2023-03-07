import 'dart:math';

import 'package:boxy/flex.dart';
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final content = WorkContent.fromPath(path);
          final detailLeftPadding = min(102.0, 0.1 * constraints.maxWidth);
          final detailRightPadding = min(64.0, 0.1 * constraints.maxWidth);

          final summary = Text(
            content.summary,
            style: heading4.textStyle,
          ).padding(
            left: detailLeftPadding,
            right: detailRightPadding,
            bottom: 24,
          );
          return showDetail
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BoxyRow(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            PhosphorIcons.arrowElbowUpLeftBold,
                            size: 32,
                          ),
                          onPressed: () => context.go('/works'),
                        ).fittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.topCenter,
                        ),
                        Dominant.expanded(
                          child: BoxyRow(
                            children: [
                              Dominant.expanded(
                                child: ColoredText(
                                  content.name,
                                  color: primary03,
                                  style: heading2,
                                ).padding(left: 4).fittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                    ),
                              ),
                              Text(content.time, style: heading2.textStyle)
                                  .fittedBox(),
                            ],
                          ).padding(top: 6.8),
                        ),
                      ],
                    ).padding(
                      left: max(0, detailLeftPadding - 38),
                      right: detailRightPadding,
                      top: 24,
                      bottom: 12,
                    ),
                    const ColoredBox(color: Colors.black).height(2).padding(
                          left: detailLeftPadding,
                          right: detailRightPadding,
                          bottom: 16,
                        ),
                    if (MediaQuery.of(context).size.width < 700)
                      summary.width(700).fittedBox()
                    else
                      summary,
                    WorkContentDisplay(path: path),
                    const SizedBox(width: 0, height: 64),
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
                    onTap: () => context.go('/$path'),
                  )
                  .mouseRegion(cursor: SystemMouseCursors.click);
        },
      );
}
