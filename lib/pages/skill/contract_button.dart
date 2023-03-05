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
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(PhosphorIcons.xSquare),
        onPressed: onPressed,
      )
          .fittedBox()
          .constrained(width: 40 * animation, height: 40 * animation)
          .opacity(animation)
          .mouseRegion(cursor: SystemMouseCursors.click);
}
