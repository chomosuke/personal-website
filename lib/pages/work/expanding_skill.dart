import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../contents/work.dart';
import '../skill/button_skill.dart';

class ExpandingSkill extends HookWidget {
  const ExpandingSkill({
    super.key,
    required this.content,
    required this.selected,
    required this.onSelectChange,
    required this.textHeight,
  });

  final LinkSpanContent content;
  final bool selected;
  final void Function(bool) onSelectChange;
  final double textHeight;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);
    final controller = useAnimationController(duration: duration);
    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    if (selected) {
      controller.forward();
    } else {
      controller.reverse();
    }

    const skillWidth = 400;
    const skillHeight = 256;

    final key = useMemoized(GlobalKey.new);
    final size = useRef<Size?>(null);
    final alignment = useState<Alignment?>(null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      size.value = (key.currentContext!.findRenderObject()! as RenderBox).size;
      final offset = (key.currentContext!.findRenderObject()! as RenderBox)
          .localToGlobal(Offset.zero);
      if (offset.dx > MediaQuery.of(context).size.width - skillWidth) {
        if (offset.dy > MediaQuery.of(context).size.height - skillHeight) {
          alignment.value = Alignment.bottomRight;
        } else {
          alignment.value = Alignment.topRight;
        }
      } else {
        if (offset.dy > MediaQuery.of(context).size.height - skillHeight) {
          alignment.value = Alignment.bottomLeft;
        } else {
          alignment.value = Alignment.topLeft;
        }
      }
    });

    return PortalTarget(
      visible: animation > 0,
      anchor: Aligned(
        follower: alignment.value ?? Alignment.topLeft,
        target: alignment.value ?? Alignment.topLeft,
      ),
      portalFollower: ButtonSkill(
        buttonText: content.text,
        path: content.path,
        textHeight: textHeight,
        animation: animation,
        onClose: () => onSelectChange(false),
      )
          .constrained(
            width: (size.value?.width ?? 0) + skillWidth * animation,
            height: (size.value?.height ?? 0) + skillHeight * animation,
          )
          .backgroundColor(Colors.white),
      child: ButtonSkill(
        buttonText: content.text,
        key: key,
        path: content.path,
        textHeight: textHeight,
        animation: 0,
        onClick: () => onSelectChange(true),
      ),
    );
  }
}
