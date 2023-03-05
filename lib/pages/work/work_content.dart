import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/popup_button.dart';
import '../../contents/work.dart';
import '../../styles.dart';
import 'expanding_skill.dart';

class WorkContentDisplay extends HookWidget {
  const WorkContentDisplay({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final content = WorkContent.fromPath(path);
    final selectedSkill = useState<LinkSpanContent?>(null);
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                for (final point in content.description) ...[
                  for (final spanContent in point)
                    if (spanContent is TextSpanContent)
                      TextSpan(text: spanContent.text)
                    else if (spanContent is LinkSpanContent)
                      if (spanContent.path.substring(0, 6) == 'skills')
                        WidgetSpan(
                          child: ExpandingSkill(
                            key: ValueKey(path + spanContent.path),
                            textHeight: 16,
                            selected: selectedSkill.value == spanContent,
                            onSelectChange: (selected) {
                              if (selected) {
                                selectedSkill.value = spanContent;
                              } else {
                                selectedSkill.value = null;
                              }
                            },
                            path: spanContent.path,
                          ),
                        )
                      else
                        WidgetSpan(
                          child: PopupButton(
                            onClick: () {
                              context.go(spanContent.path);
                            },
                            color: primary03,
                            child: Text(
                              spanContent.text,
                              style: heading3.textStyle,
                            )
                                .fittedBox(fit: BoxFit.fitHeight)
                                .height(16)
                                .padding(horizontal: 6, vertical: 2),
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
        ],
      ).padding(
        horizontal: constraints.maxWidth < 1200 / 0.8
            ? 0.1 * constraints.maxWidth
            : (constraints.maxWidth - 1200) / 2,
      ),
    );
  }
}
