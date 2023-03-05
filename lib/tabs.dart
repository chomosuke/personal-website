import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class Tabs extends HookWidget {
  const Tabs({
    super.key,
    required this.tabs,
    required this.focusedTab,
  });

  final List<TabElement> tabs;
  final int focusedTab;

  @override
  Widget build(BuildContext context) {
    final keys =
        useMemoized(() => [for (var i = 0; i < tabs.length; i++) GlobalKey()]);

    return CustomMultiChildLayout(
      delegate: _TabsLayoutDelegate(height: 94, overlap: 12),
      children: [
        for (var i = tabs.length - 1; i > focusedTab; i--)
          LayoutId(
            id: i,
            child: _DecoratedChild(
              key: keys[i],
              focused: false,
              tabElement: tabs[i],
            ),
          ),
        for (var i = 0; i < focusedTab; i++)
          LayoutId(
            id: i,
            child: _DecoratedChild(
              key: keys[i],
              focused: false,
              tabElement: tabs[i],
            ),
          ),
        LayoutId(
          id: focusedTab,
          child: _DecoratedChild(
            key: keys[focusedTab],
            focused: true,
            tabElement: tabs[focusedTab],
          ),
        ),
      ],
    ).backgroundColor(const Color(0xFF4B4B4B)).clipRect();
  }
}

class _DecoratedChild extends HookWidget {
  const _DecoratedChild({
    super.key,
    required this.focused,
    required this.tabElement,
  });
  final bool focused;
  final TabElement tabElement;
  @override
  Widget build(BuildContext context) {
    final hoverController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final hoverAnimation = useAnimation(
      CurvedAnimation(parent: hoverController, curve: Curves.ease),
    );
    final focusController = useAnimationController(
      duration: const Duration(milliseconds: 500),
      initialValue: focused ? 1 : 0,
    );
    final focusAnimation = useAnimation(
      CurvedAnimation(parent: focusController, curve: Curves.ease),
    );

    useValueChanged(focused, (_, void __) async {
      if (focused) {
        try {
          await hoverController.reverse().orCancel;
          // ignore: avoid_catches_without_on_clauses, empty_catches
        } catch (e) {}
        await focusController.forward();
      } else {
        await focusController.reverse();
      }
    });

    return tabElement
        .childFactory(focusAnimation)
        .padding(horizontal: 48, top: 4 + 8 * (1 - hoverAnimation))
        .height(70 + 8 * focusAnimation)
        .decorated(
          color: focused ? Colors.white : const Color(0xFFF3F3F3),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
          boxShadow: [
            const BoxShadow(
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        )
        .gestures(onTap: tabElement.onTap)
        .mouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (!focused) {
              hoverController.forward();
            }
          },
          onExit: (_) => hoverController.reverse(),
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

class TabElement {
  TabElement({required this.childFactory, this.onTap});
  final Widget Function(double) childFactory;
  final void Function()? onTap;
}
