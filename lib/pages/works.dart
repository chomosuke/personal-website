import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/discord_inception.dart';
import '../contents/get_paths.dart';
import 'work.dart';

class Works extends HookWidget {
  Works({super.key}) : pathsFuture = getPaths('works');

  final Future<List<String>> pathsFuture;

  @override
  Widget build(BuildContext context) {
    final paths = useFuture(pathsFuture);
    return paths.hasData
        ? DiscordInception(
            children: [
              for (final path in paths.data!)
                Work(path: path).gestures(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.go('/$path');
                  },
                )
            ],
          )
        : const Text('loading').center();
  }
}
