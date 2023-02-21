import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/grid_morph.dart';
import '../contents/get_paths.dart';
import 'skill.dart';

class Skills extends HookWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    final paths = useFuture(getPaths('skills'));

    return paths.hasData
        ? GridMorph(
            childrenCount: paths.data!.length,
            childFactory: (context, i, hovered, clicked) =>
                Skill(path: paths.data![i % paths.data!.length]),
          )
        : const Text('loading').center();
  }
}
