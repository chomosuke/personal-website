import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import 'tabs.dart';

class TabbedPages extends HookWidget {
  const TabbedPages({super.key, required this.children});

  final List<TabbedPage> children;

  @override
  Widget build(BuildContext context) {
    final focusedPage = useState(0);
    return Column(
      children: [
        Tabs(
          height: 93,
          overlap: 32,
          focusedTab: focusedPage.value,
          children: [
            for (var i = 0; i < children.length; i++)
              children[i]
                  .tab
                  .gestures(
                    onTap: () {
                      focusedPage.value = i;
                    },
                  )
                  .padding(left: i == 0 ? 16 : 48, right: 32, vertical: 4)
                  .decorated(
                    color: i == focusedPage.value
                        ? Colors.white
                        : const Color(0xFFF3F3F3),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(10),
                    ),
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(1, -1),
                        blurRadius: 2,
                      ),
                    ],
                  )
          ],
        ).decorated(color: const Color(0xFF525252)),
        children[focusedPage.value].content.expanded(),
      ],
    );
  }
}

class TabbedPage {
  TabbedPage({required this.content, required this.tab});
  final Widget content;
  final Widget tab;
}
