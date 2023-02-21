import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:styled_widget/styled_widget.dart';

import 'components/discord_inception.dart';
import 'components/grid_morph.dart';
import 'skills/skills.dart';
import 'tabbed_pages/tabbed_pages.dart';
import 'works/works.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Richard Li',
      home: TabbedPages(
        children: [
          TabbedPage(
            tab: const Text('Skills', style: TextStyle(fontSize: 32)),
            content: const Skills(),
          ),
          TabbedPage(
            tab: const Text('Works', style: TextStyle(fontSize: 32)),
            content: const Works(),
          ),
        ],
      ).material(),
    );
  }
}
