import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:styled_widget/styled_widget.dart';

import '../skill/skill.dart';

class ExpandingSkill extends HookWidget {
  const ExpandingSkill({
    super.key,
    required this.path,
    required this.selected,
    required this.onSelectChange,
  });

  final String path;
  final bool selected;
  final void Function(bool) onSelectChange;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);
    final controller = useAnimationController(duration: duration);
    final animation = useAnimation(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    final overlay = useState(false);
    useValueChanged(selected, (s, void r) {
      () async {
        if (selected) {
          overlay.value = true;
          await controller.forward();
        } else {
          await controller.reverse();
          overlay.value = false;
        }
      }();
    });

    final key = useMemoized(GlobalKey.new);
    final size = useRef<Size?>(null);
    final alignment = useState<Alignment?>(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      size.value = (key.currentContext!.findRenderObject()! as RenderBox).size;
      final offset = (key.currentContext!.findRenderObject()! as RenderBox)
          .localToGlobal(Offset.zero);
      if (offset.dx > MediaQuery.of(context).size.width - 600) {
        if (offset.dy > MediaQuery.of(context).size.height - 600) {
          alignment.value = Alignment.bottomRight;
        } else {
          alignment.value = Alignment.topRight;
        }
      } else {
        alignment.value = Alignment.topLeft;
      }
    });

    return PortalTarget(
      visible: overlay.value,
      anchor: Aligned(
        follower: alignment.value ?? Alignment.topLeft,
        target: alignment.value ?? Alignment.topLeft,
      ),
      portalFollower: Skill(
        path: path,
        state: selected ? SkillState.detailed : SkillState.button,
        animateFrom: SkillState.button,
        animationDuration: duration,
        onClose: () => onSelectChange(false),
      )
          .constrained(
            width: (size.value?.width ?? 0) + 500 * animation,
            height: (size.value?.height ?? 0) + 500 * animation,
          )
          .backgroundColor(Colors.white),
      child: Skill(
        key: key,
        path: path,
        state: SkillState.button,
        onClick: () => onSelectChange(true),
      ),
    );
  }
}
