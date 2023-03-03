import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/discord_inception.dart';
import '../contents/get_paths.dart';
import 'work.dart';

final _globalKeys = <int, GlobalKey>{};

class Works extends HookWidget {
  const Works({super.key});

  @override
  Widget build(BuildContext context) {
    final paths = getPaths('works');
    return DiscordInception(
      childFactory: (i) {
        if (_globalKeys[i] == null) {
          _globalKeys[i] = GlobalKey();
        }
        return Work(
          key: _globalKeys[i],
          path: paths[i % paths.length],
        );
      },
    );
  }
}
