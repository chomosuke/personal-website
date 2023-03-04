import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class PopupButton extends HookWidget {
  const PopupButton({
    super.key,
    required this.child,
    required this.color,
    this.onClick,
    this.size,
    this.offset = const Offset(-4, -2),
  });

  final void Function()? onClick;
  final Widget child;
  final Size? size;
  final Color color;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );
    final animation = useAnimation(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );
    return CustomBoxy(
      delegate: _PopupButtonDelegate(size),
      children: [
        BoxyId(id: #color, child: Container(color: color)),
        BoxyId(
          id: #content,
          child: (size != null ? child.center() : child)
              .border(all: 2)
              .backgroundColor(Colors.white)
              .translate(offset: offset * animation),
        ),
      ],
    )
        .gestures(
          onTap: onClick,
          behavior: HitTestBehavior.opaque,
        )
        .mouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => controller.forward(),
          onExit: (_) => controller.reverse(),
        );
  }
}

class _PopupButtonDelegate extends BoxyDelegate {
  _PopupButtonDelegate(this.size);
  final Size? size;

  @override
  Size layout() {
    final color = getChild(#color);
    final content = getChild(#content);
    if (size != null) {
      final s = size!;
      color.layout(BoxConstraints.tight(s));
      content.layout(BoxConstraints.tight(s));
      return s;
    } else {
      final s = content.layout(constraints);
      color.layout(BoxConstraints.tight(s));
      return s;
    }
  }
}
