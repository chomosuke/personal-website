import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    super.key,
    required this.height,
    required this.overlap,
    required this.children,
    required this.focusedTab,
  });

  final double overlap;
  final double height;
  final List<Widget> children;
  final int focusedTab;

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: _TabsLayoutDelegate(height: height, overlap: overlap),
      children: [
        for (var i = children.length - 1; i >= 0; i--)
          if (i != focusedTab)
            LayoutId(
              id: i,
              child: children[i],
            ),
        LayoutId(
          id: focusedTab,
          child: children[focusedTab],
        ),
      ],
    );
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
