import 'dart:math';

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

    const textHeight = 16.0;
    const buttonPaddingTop = 0.0;

    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: content.screenshot, fit: BoxFit.contain)
              .padding(all: 2)
              .border(all: 2)
              .center(),
          if (content.quickLinks.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final quickLink in content.quickLinks)
                  PopupButton(
                    color: primary03,
                    onClick: () {
                      launchUrl(Uri.parse(quickLink.link));
                    },
                    child: Row(
                      children: [
                        if (quickLink.icon != null)
                          Icon(quickLink.icon, size: 32).padding(right: 8),
                        Text(quickLink.text, style: heading4.textStyle),
                      ],
                    ).padding(horizontal: 12).height(48),
                  ).padding(right: 22, top: 15),
              ],
            ).constrained(minWidth: 500).fittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                ),
          const SizedBox(width: 0, height: 16),
          for (final point in content.description)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${'        ' * point.depth}•  ', style: paragraph1),
                Text.rich(
                  TextSpan(
                    children: [
                      for (final spanContent in point.content)
                        if (spanContent is TextSpanContent)
                          TextSpan(text: spanContent.text, style: paragraph1)
                        else if (spanContent is BoldTextSpanContent)
                          TextSpan(
                            text: spanContent.text,
                            style: paragraph1Bold,
                          )
                        else if (spanContent is CodeSpanContent)
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              spanContent.text,
                              style: paragraph1Code,
                            )
                                .padding(horizontal: 6, vertical: 2)
                                .decorated(
                                  color:
                                      const Color.fromRGBO(175, 184, 193, 0.2),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                )
                                .padding(top: 1),
                          )
                        else if (spanContent is LinkSpanContent)
                          if (spanContent.path.substring(0, 6) == 'skills')
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: ExpandingSkill(
                                key: ValueKey(path + spanContent.path),
                                content: spanContent,
                                textHeight: textHeight,
                                selected: selectedSkill.value == spanContent,
                                onSelectChange: (selected) {
                                  if (selected) {
                                    selectedSkill.value = spanContent;
                                  } else {
                                    selectedSkill.value = null;
                                  }
                                },
                              ).padding(top: buttonPaddingTop),
                            )
                          else
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: PopupButton(
                                onClick: () => context.go(spanContent.path),
                                color: primary03,
                                child: Text(
                                  spanContent.text,
                                  style: heading3.textStyle,
                                )
                                    .fittedBox(fit: BoxFit.fitHeight)
                                    .height(textHeight)
                                    .padding(horizontal: 6, vertical: 2),
                              ).padding(top: buttonPaddingTop),
                            )
                        else if (spanContent is ExternLinkSpanContent)
                          TextSpan(
                            text: spanContent.text,
                            style: link,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(spanContent.externLink));
                              },
                          ),
                    ],
                  ),
                ).expanded(),
              ],
            ).padding(bottom: 6),
        ],
      ).padding(
        horizontal:
            max(0.1 * constraints.maxWidth, (constraints.maxWidth - 1000) / 2),
      ),
    );
  }
}
