import 'package:boxy/flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../contents/popup_button.dart';
import '../styles.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        children: [
          Column(
            children: [
              Container(color: const Color(0xFFC6E2AF)).expanded(),
              SizedBox.fromSize(size: const Size(0, 48)),
              Row(
                children: [
                  PopupButton(
                    text: 'skills',
                    textStyle: heading1,
                    size: const Size(400, 100),
                    color: primary02,
                    onClick: () {
                      context.go('/skills');
                    },
                  ),
                  const Spacer(),
                  PopupButton(
                    text: 'works',
                    textStyle: heading1,
                    size: const Size(400, 100),
                    color: primary03,
                    onClick: () {
                      context.go('/works');
                    },
                  ),
                ],
              ),
            ],
          )
              .width(892)
              .padding(
                bottom: 0.24 * constraints.maxHeight,
                right: 48,
                top: 110,
              )
              .alignment(Alignment.centerRight),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, my name is', style: heading1).padding(bottom: 24),
              Text('Richard\nLi', style: display1),
            ],
          ).padding(top: 84, left: 72),
        ],
      ),
    );
  }
}
