import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/colored_text.dart';
import '../../components/popup_button.dart';
import '../../contents/work.dart';
import '../../styles.dart';
import '../skill/skill.dart';

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
                for (final point in content.description) ...[
                  for (final spanContent in point)
                    if (spanContent is TextSpanContent)
                      TextSpan(text: spanContent.text)
                    else if (spanContent is LinkSpanContent)
                      if (spanContent.path.substring(0, 6) == 'skills')
                        WidgetSpan(
                          child: Skill(
                            path: spanContent.path,
                            state: SkillState.button,
                          ),
                        )
                      else
                        WidgetSpan(
                          child: PopupButton(
                            text: spanContent.text,
                            onClick: () {
                              context.go(spanContent.path);
                            },
                            color: primary03,
                          ),
                        )
                    else if (spanContent is ExternLinkSpanContent)
                      TextSpan(
                        text: spanContent.text,
                        style: const TextStyle(
                          color: Color(0xFF0000EE),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse(spanContent.externLink));
                          },
                      ),
                  const TextSpan(text: '\n'),
                ]
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
          )
            .border(all: 1)
            .decorated(color: Colors.white)
            .gestures(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.go('/$path');
              },
            )
            .mouseRegion(cursor: SystemMouseCursors.click);
  }
}
