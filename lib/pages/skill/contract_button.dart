import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:styled_widget/styled_widget.dart';

class ContractButton extends StatelessWidget {
  const ContractButton({
    super.key,
    required this.animation,
    this.onPressed,
  });
  final void Function()? onPressed;
  final double animation;
  @override
  Widget build(BuildContext context) =>
      const Icon(PhosphorIcons.xSquare, size: 36)
          .gestures(onTap: onPressed, behavior: HitTestBehavior.opaque)
          .fittedBox()
          .constrained(width: 36 * animation, height: 36 * animation)
          .opacity(animation)
          .mouseRegion(cursor: SystemMouseCursors.click);
}
