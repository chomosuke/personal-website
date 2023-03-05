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
  });

  final void Function()? onClick;
  final Widget child;
  final Color color;

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

    final key = useMemoized(GlobalKey.new);
    final offset = useRef<Offset?>(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = (key.currentContext!.findRenderObject()! as RenderBox).size;
      final o =
          size.height < 30 ? size.height * 0.1 : 3 + (size.height - 30) * 0.05;
      offset.value = Offset(-2 * o, -o);
    });

    return CustomBoxy(
      key: key,
      delegate: _PopupButtonDelegate(),
      children: [
        BoxyId(id: #color, child: Container(color: color)),
        BoxyId(
          id: #content,
          child: child
              .border(all: 2)
              .backgroundColor(Colors.white)
              .translate(
                offset: (offset.value ?? Offset.zero) * animation,
              ),
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
  _PopupButtonDelegate();

  @override
  Size layout() {
    final color = getChild(#color);
    final content = getChild(#content);
    final s = content.layout(constraints);
    color.layout(BoxConstraints.tight(s));
    return s;
  }
}
