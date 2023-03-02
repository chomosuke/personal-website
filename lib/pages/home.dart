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
              for (var i = 0; i < 20; i++) ...[
                Row(
                  children: [
                    for (var j = 0; j < 20; j++) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFFED9555),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ],
                ),
                const Spacer(),
              ],
            ],
          )
              .constrained(width: 400, height: 400)
              .padding(all: 264)
              .alignment(Alignment.topLeft),
          Column(
            children: [
              ColoredBox(
                color: const Color(0xFFC6E2AF),
                child:
                    Text('I code stuffs, all sorts of\nstuff', style: heading1)
                        .padding(bottom: 84, left: 52)
                        .alignment(Alignment.bottomLeft),
              ).expanded(),
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
