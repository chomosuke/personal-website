import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class PopupButton extends HookWidget {
  const PopupButton({
    super.key,
    required this.text,
    required this.textStyle,
    required this.size,
    required this.onClick,
    required this.color,
    this.offset = const Offset(-4, -2),
  });

  final void Function() onClick;
  final String text;
  final TextStyle textStyle;
  final Size size;
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
    return Stack(
      children: [
        Container(color: color),
        Text(text, style: textStyle)
            .center()
            .border(all: 2)
            .backgroundColor(Colors.white)
            .translate(offset: offset * animation),
      ],
    )
        .constrained(
          width: size.width,
          height: size.height,
        )
        .gestures(
          onTap: onClick,
          behavior: HitTestBehavior.opaque,
        )
        .mouseRegion(
          onEnter: (_) => controller.forward(),
          onExit: (_) => controller.reverse(),
        );
  }
}
