import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class TabbedPages extends HookWidget {
  const TabbedPages({super.key, required this.children});

  final List<TabbedPage> children;

  @override
  Widget build(BuildContext context) {
    final focusedPage = useState(0);
    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < children.length; i++)
              children[i]
                  .tab
                  .gestures(
                    onTap: () {
                      focusedPage.value = i;
                    },
                  )
                  .padding(left: 16, right: 32, vertical: 4)
                  .decorated(
                    color: i == focusedPage.value ? Colors.white : Colors.grey,
                    border: Border.all(width: 0),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(27.5),
                    ),
                  )
                  .padding(top: 2.5, right: 2.5, bottom: 0, left: 0)
                  .decorated(
                    color: Colors.black,
                    border: Border.all(width: 0),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                    ),
                  ),
          ],
        ).decorated(color: Colors.grey),
        children[focusedPage.value].content.expanded(),
      ],
    );
  }
}

class TabbedPage {
  TabbedPage(this.content, this.tab);
  final Widget content;
  final Widget tab;
}
