import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'styles.dart';

class NameIcon extends HookWidget {
  const NameIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );
    return PortalTarget(
      visible: animation != 0,
      anchor: const Aligned(
        target: Alignment.topLeft,
        follower: Alignment.topLeft,
        offset: Offset(-16, 0),
      ),
      portalFollower: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(PhosphorIcons.caretUp),
              const SizedBox(width: 8),
              Text(
                'Richard',
                style: heading4.textStyle,
              ),
            ],
          )
              .padding(all: 16)
              .gestures(
                onTap: controller.reverse,
                behavior: HitTestBehavior.opaque,
              )
              .mouseRegion(cursor: SystemMouseCursors.click),
          const ColoredBox(color: Colors.black)
              .constrained(width: 100, height: 2),
          Text('GitHub', style: heading4.textStyle)
              .padding(top: 16, bottom: 8, left: 40, right: 16)
              .gestures(
                onTap: () => launchUrlString(
                  'https://github.com/chomosuke',
                ),
                behavior: HitTestBehavior.opaque,
              )
              .mouseRegion(cursor: SystemMouseCursors.click),
          Text('LinkedIn', style: heading4.textStyle)
              .padding(vertical: 8, bottom: 8, left: 40, right: 16)
              .gestures(
                onTap: () => launchUrlString(
                  'https://www.linkedin.com/in/shuang-li-bba020181/',
                ),
                behavior: HitTestBehavior.opaque,
              )
              .mouseRegion(cursor: SystemMouseCursors.click),
          Text('Resumé', style: heading4.textStyle)
              .padding(top: 8, bottom: 16, left: 40, right: 16)
              .gestures(
                onTap: () => launchUrlString(
                  'https://github.com/chomosuke/resume/raw/master/resume.pdf',
                ),
                behavior: HitTestBehavior.opaque,
              )
              .mouseRegion(cursor: SystemMouseCursors.click),
        ],
      ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          const BoxShadow(
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ).opacity(animation),
      child: Row(
        children: [
          const Icon(PhosphorIcons.caretDown, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            'Richard',
            style: heading4.textStyle.apply(color: Colors.white),
          ),
          const SizedBox(width: 16),
          Image.asset(
            'content/assets/logo.png',
            height: 60,
            width: 60,
          ).clipOval(),
        ],
      )
          .gestures(
            onTap: controller.forward,
            behavior: HitTestBehavior.opaque,
          )
          .mouseRegion(cursor: SystemMouseCursors.click),
    );
  }
}
