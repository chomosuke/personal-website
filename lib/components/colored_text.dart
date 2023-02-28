import 'package:boxy/boxy.dart';
import 'package:flutter/material.dart';

class ColoredTextStyle {
  ColoredTextStyle({
    required this.textStyle,
    required this.topOffset,
    required this.colorHeight,
  });
  final TextStyle textStyle;
  final double topOffset;
  final double colorHeight;
}

class ColoredText extends StatelessWidget {
  const ColoredText(
    this.data, {
    super.key,
    required this.color,
    required this.style,
  });

  final Color color;
  final String data;
  final ColoredTextStyle style;
  @override
  Widget build(BuildContext context) {
    return CustomBoxy(
      delegate: ColoredTextDelegate(
        topOffset: style.topOffset,
        height: style.colorHeight,
      ),
      children: [
        BoxyId(
          id: #color,
          child: Container(
            width: double.infinity,
            height: style.colorHeight,
            color: color,
          ),
        ),
        BoxyId(
          id: #text,
          child: Text(data, style: style.textStyle),
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
      // ..position(Offset(0, topOffset));

    return textSize;
  }
}
