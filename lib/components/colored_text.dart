import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';

class ColoredText extends StatelessWidget {
  const ColoredText(
    this.data, {
    super.key,
    required this.color,
    required this.style,
    required this.colorHeight,
    required this.topOffset,
  });

  final Color color;
  final String data;
  final TextStyle style;
  final double colorHeight;
  final double topOffset;
  @override
  Widget build(BuildContext context) {
    return CustomBoxy(
      delegate: ColoredTextDelegate(topOffset: topOffset, height: colorHeight),
      children: [
        BoxyId(
          id: #color,
          child: Container(
            width: double.infinity,
            height: colorHeight,
            color: color,
          ),
        ),
        BoxyId(
          id: #text,
          child: Text(data, style: style),
        ),
      ],
    );
  }
}

class ColoredTextDelegate extends BoxyDelegate {
  ColoredTextDelegate({required this.topOffset, required this.height});

  final double topOffset;
  final double height;

  @override
  Size layout() {
    final text = getChild(#text);
    final color = getChild(#color);

    final Size textSize = text.layout(constraints);
    color
      ..layout(BoxConstraints.tight(Size(textSize.width, height)))
      ..position(Offset(height * 0.45, topOffset + height * 0.26));

    return textSize;
  }
}
