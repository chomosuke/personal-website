import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HorizontalListView extends HookWidget {
  const HorizontalListView({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final worksScrollController = useScrollController();

    var scrollConfiguration = ScrollConfiguration.of(context);
    scrollConfiguration = scrollConfiguration.copyWith(
      dragDevices:
          scrollConfiguration.dragDevices.union({PointerDeviceKind.mouse}),
    );

    return Listener(
      onPointerSignal: (signal) {
        if (signal is PointerScrollEvent) {
          final position = worksScrollController.position;
          final newOffset = max(
            0.0,
            min(
              position.maxScrollExtent,
              position.pixels + signal.scrollDelta.dy / 2,
            ),
          );
          worksScrollController.jumpTo(newOffset);
        }
      },
      child: ScrollConfiguration(
        behavior: scrollConfiguration,
        child: ListView(
          controller: worksScrollController,
          scrollDirection: Axis.horizontal,
          children: children,
        ),
      ),
    );
  }
}
