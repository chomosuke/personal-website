import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/discord_inception.dart';
import '../contents/get_paths.dart';
import 'work.dart';

class Works extends HookWidget {
  const Works({super.key});

  @override
  Widget build(BuildContext context) {
    final paths = useFuture(getPaths('works'));
    return paths.hasData
        ? DiscordInception(
            children: [for (final path in paths.data!) Work(path: path)],
          )
        : const Text('loading').center();
  }
}
