import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class DottedGrid extends StatelessWidget {
  const DottedGrid({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            for (var i = 0; i < constraints.maxHeight / 20 - 1; i++)
              Row(
                children: [
                  for (var j = 0; j < constraints.maxWidth / 20 - 1; j++)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFED9555),
                        shape: BoxShape.circle,
                      ),
                    ).center().constrained(width: 20, height: 20),
                ],
              ),
          ],
        ),
      );
}
