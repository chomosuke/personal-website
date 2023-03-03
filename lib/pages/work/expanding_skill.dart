import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:styled_widget/styled_widget.dart';

import '../skill/skill.dart';

class ExpandingSkill extends HookWidget {
  const ExpandingSkill({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final clicked = useState(false);

    const duration = Duration(milliseconds: 500);
    final controller = useAnimationController(duration: duration);
    final animation = useAnimation(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    final key = useMemoized(GlobalKey.new);
    final size = useRef<Size?>(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      size.value = (key.currentContext!.findRenderObject()! as RenderBox).size;
    });

    return PortalTarget(
      visible: clicked.value,
      anchor: const Aligned(
        follower: Alignment.topLeft,
        target: Alignment.topLeft,
      ),
      portalFollower: Skill(
        path: path,
        state: SkillState.detailed,
        animateFrom: SkillState.button,
        animationDuration: duration,
        onClose: () {
          clicked.value = false;
        },
      ).constrained(
        width: 500,
        height: 500,
      ).backgroundColor(Colors.white),
      child: Skill(
        key: key,
        path: path,
        state: SkillState.button,
        onClick: () {
          clicked.value = true;
        },
      ),
    );
  }
}