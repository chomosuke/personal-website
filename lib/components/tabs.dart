import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.tabs,
    required this.focusedTab,
  });

  final List<TabElement> tabs;
  final int focusedTab;

  @override
  Widget build(BuildContext context) {
    Widget decoratedChild(int i) => tabs[i]
            .child
            .padding(left: 32, right: 32, vertical: 4)
            .decorated(
          color: i == focusedTab ? Colors.white : const Color(0xFFF3F3F3),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            const BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ).gestures(onTap: tabs[i].onTap);

    return CustomMultiChildLayout(
      delegate: _TabsLayoutDelegate(height: 93, overlap: 16),
      children: [
        for (var i = tabs.length - 1; i >= 0; i--)
          if (i != focusedTab)
            LayoutId(
              id: i,
              child: decoratedChild(i),
            ),
        LayoutId(
          id: focusedTab,
          child: decoratedChild(focusedTab),
        ),
      ],
    ).decorated(color: const Color(0xFF525252));
  }
}

class _TabsLayoutDelegate extends MultiChildLayoutDelegate {
  _TabsLayoutDelegate({required this.height, required this.overlap});

  final double overlap;
  final double height;

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, height);
  }

  @override
  void performLayout(Size size) {
    var i = 0;
    var childPosX = 0.0;
    while (hasChild(i)) {
      final childSize = layoutChild(i, BoxConstraints.loose(size));
      positionChild(i, Offset(childPosX, height - childSize.height));
      childPosX += childSize.width - overlap;
      i++;
    }
  }

  @override
  bool shouldRelayout(_TabsLayoutDelegate old) =>
      old.height != height || old.overlap != overlap;
}

class TabElement {
  TabElement({required this.child, this.onTap});
  final Widget child;
  final void Function()? onTap;
}
