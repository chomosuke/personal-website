import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class Work extends HookWidget {
  const Work({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Text(path).center();
  }
}
