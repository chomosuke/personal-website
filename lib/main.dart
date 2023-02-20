import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:styled_widget/styled_widget.dart';

import 'components/discord_inception.dart';
import 'components/grid_morph.dart';
import 'tabbed_pages/tabbed_pages.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.red,
      Colors.blue,
      Colors.cyan,
      Colors.yellow,
      Colors.orange,
      Colors.teal,
      Colors.lime,
      Colors.grey,
      Colors.black,
      Colors.pink,
      Colors.white,
      Colors.green,
      Colors.amber,
      Colors.brown,
      Colors.purple,
      Colors.indigo,
      Colors.yellow,
      Colors.orange,
      Colors.red,
      Colors.blue,
      Colors.cyan,
      Colors.teal,
      Colors.lime,
      Colors.grey,
      Colors.black,
      Colors.pink,
      Colors.white,
      Colors.green,
      Colors.amber,
      Colors.red,
      Colors.pink,
      Colors.brown,
      Colors.purple,
      Colors.indigo,
      Colors.yellow,
      Colors.orange,
    ];

    return MaterialApp(
      title: 'Richard Li',
      home: TabbedPages(
        children: [
          TabbedPage(
            tab: const Text('Skills', style: TextStyle(fontSize: 32)),
            content: GridMorph(
              children: [
                for (Color color in colors) Container(color: color),
              ],
              defaultFactory: (context, i) =>
                  Container(color: colors[i % colors.length]),
            ),
          ),
          TabbedPage(
            tab: const Text('Works', style: TextStyle(fontSize: 32)),
            content: DiscordInception(
              children: [
                for (Color color in colors) Container(color: color),
              ],
            ),
          ),
        ],
      ).material(),
    );
  }
}
