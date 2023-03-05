import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../components/popup_button.dart';
import '../../styles.dart';
import 'dotted_grid.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;

        final skillButton = PopupButton(
          color: primary02,
          onClick: () {
            context.go('/skills');
          },
          child: Text(
            'skills',
            style: heading1,
          ).center().constrained(width: 400, height: 100),
        );

        final worksButton = PopupButton(
          color: primary03,
          onClick: () {
            context.go('/works');
          },
          child: Text(
            'works',
            style: heading1,
          ).center().constrained(width: 400, height: 100),
        );

        final quirkySentence =
            Text('I code stuff, all sorts of stuff.', style: heading1);

        if (width < 900) {
          final buttons = width > 500
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    skillButton,
                    const SizedBox.square(dimension: 32),
                    worksButton,
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    skillButton,
                    const SizedBox.square(dimension: 32),
                    worksButton,
                  ],
                );

          final introFittedBox = height < 607 || width < 640;
          Widget intro = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hi, my name is', style: heading1).padding(bottom: 24),
              Text('Richard\nLi', style: display1),
            ],
          );

          intro = introFittedBox ? intro.fittedBox() : intro;

          return Stack(
            children: [
              const ColoredBox(color: Color(0xFFEFFFD1))
                  .constrained(width: width * 0.8, height: width * 0.8)
                  .padding(top: 100, horizontal: 32)
                  .alignment(Alignment.topRight),
              const DottedGrid()
                  .constrained(width: width * 0.6, maxHeight: width * 0.6)
                  .padding(
                    top: min(180, width * 180 / 540),
                    bottom: height * 0.48,
                    left: min(120, width * 120 / 540),
                  )
                  .alignment(Alignment.topLeft),
              const ColoredBox(
                color: Color(0xFFC6E2AF),
                child: SizedBox.expand(),
              )
                  .height(width * 0.5)
                  .padding(left: width / 1600 * 480, top: 32)
                  .alignment(Alignment.topLeft),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  intro,
                  const Spacer(),
                  if (width < 450)
                    quirkySentence.width(450).fittedBox(fit: BoxFit.scaleDown)
                  else
                    quirkySentence,
                  const Spacer(),
                  buttons.fittedBox(fit: BoxFit.scaleDown).center(),
                ],
              ),
            ],
          ).padding(all: 32);
        }

        final verticalButton = height < 800;

        final buttonsChildren = [
          skillButton,
          const SizedBox.square(dimension: 92),
          worksButton,
        ];
        final buttons = verticalButton
            ? (height < 500
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: buttonsChildren,
                  ).fittedBox(fit: BoxFit.scaleDown)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: buttonsChildren,
                  ))
            : Row(mainAxisSize: MainAxisSize.min, children: buttonsChildren);

        final introFittedBox = height < 607 || width < 640;
        Widget intro = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Hi, my name is', style: heading1).padding(bottom: 24),
            Text('Richard\nLi', style: display1),
            if (!introFittedBox) const Spacer(),
            if (verticalButton) quirkySentence.width(550),
          ],
        );

        intro = introFittedBox ? intro.fittedBox() : intro;

        return Stack(
          children: [
            const ColoredBox(color: Color(0xFFEFFFD1))
                .constrained(
                  width: 945,
                  height: height * 0.85 - 224,
                )
                .padding(
                  right: 146,
                  top: 224,
                )
                .alignment(Alignment.topRight),
            const DottedGrid()
                .constrained(maxWidth: 400, maxHeight: 400)
                .padding(top: 200, left: 160, bottom: 100)
                .alignment(Alignment.topLeft),
            ColoredBox(
              color: const Color(0xFFC6E2AF),
              child: verticalButton
                  ? const SizedBox.expand()
                  : quirkySentence
                      .padding(bottom: 84, left: 64, right: 100)
                      .alignment(Alignment.bottomLeft),
            )
                .padding(
                  bottom:
                      width > 1000 ? 0.3 * height : 0.3 * height * width / 1000,
                  left: width / 1600 * 480,
                  top: 32,
                )
                .alignment(Alignment.centerRight),
            if (verticalButton)
              buttons.alignment(Alignment.centerRight)
            else if (width > 1280)
              buttons
                  .padding(bottom: 0.12 * height)
                  .alignment(Alignment.bottomRight)
            else
              buttons
                  .fittedBox(fit: BoxFit.scaleDown)
                  .alignment(Alignment.bottomCenter),
            intro,
          ],
        ).padding(
          horizontal: min(84, width / 10),
          vertical: min(84, height / 600 * 84),
        );
      },
    ).constrained(maxWidth: 1600, maxHeight: 1000).center();
  }
}
