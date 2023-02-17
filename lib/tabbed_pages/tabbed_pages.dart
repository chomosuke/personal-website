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
          focusedTab: focusedPage.value,
          tabs: [
            for (var i = 0; i < children.length; i++)
              TabElement(
                child: children[i].tab,
                onTap: () {
                  focusedPage.value = i;
                },
              ),
          ],
        ),
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
