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

    Widget decorate(Widget child, void Function() onTap) {
      return child
          .center()
          .gestures(onTap: onTap, behavior: HitTestBehavior.opaque)
          .mouseRegion(cursor: SystemMouseCursors.click)
          .ripple();
    }

    return PortalTarget(
      visible: animation != 0,
      portalFollower: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          decorate(
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
            ).padding(vertical: 16, left: 8, right: 32),
            controller.reverse,
          ),
          const ColoredBox(color: Colors.black)
              .constrained(width: 128, height: 2)
              .center(),
          decorate(
            Text('GitHub', style: heading4.textStyle)
                .padding(top: 16, bottom: 8),
            () => launchUrlString(
              'https://github.com/chomosuke',
            ),
          ),
          decorate(
            Text('LinkedIn', style: heading4.textStyle).padding(vertical: 8),
            () => launchUrlString(
              'https://www.linkedin.com/in/shuang-li-bba020181/',
            ),
          ),
          decorate(
            Text('Resumé', style: heading4.textStyle)
                .padding(top: 8, bottom: 16),
            () => launchUrlString(
              'https://github.com/chomosuke/resume/raw/master/resume.pdf',
            ),
          ),
        ],
      )
          .width(168)
          .decorated(
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
          )
          .padding(right: 76, top: 18)
          .alignment(Alignment.topRight)
          .gestures(
            onTap: controller.reverse,
            behavior: HitTestBehavior.opaque,
          )
          .opacity(animation),
      child: Row(
        children: [
          const Icon(PhosphorIcons.caretDown, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            'Richard',
            style: heading4.textStyle.apply(color: Colors.white),
          ),
          const SizedBox(width: 32),
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
