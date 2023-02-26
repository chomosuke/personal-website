import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/discord_inception.dart';
import '../contents/get_paths.dart';
import 'work.dart';

final _globalKeys = <int, GlobalKey>{};

class Works extends HookWidget {
  Works({super.key}) : pathsFuture = getPaths('works');

  final Future<List<String>> pathsFuture;

  @override
  Widget build(BuildContext context) {
    final paths = useFuture(pathsFuture);
    return paths.hasData
        ? DiscordInception(
            childFactory: (i) {
              if (_globalKeys[i] == null) {
                _globalKeys[i] = GlobalKey();
              }
              return Work(
                key: _globalKeys[i],
                path: paths.data![i % paths.data!.length],
              ).gestures(
                key: ValueKey(i),
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  context.go('/${paths.data![i % paths.data!.length]}');
                },
              );
            },
          )
        : const Text('loading').center();
  }
}
