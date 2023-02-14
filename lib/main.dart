import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import 'discord_inception.dart';
import 'grid_morph.dart';

void main() {
  runApp(const App());
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final toggle = useState<bool>(true);

    const colors = [
      Colors.red,
      Colors.pink,
      Colors.blue,
      Colors.cyan,
      Colors.teal,
      Colors.lime,
      Colors.grey,
      Colors.black,
      Colors.white,
      Colors.green,
      Colors.amber,
      Colors.brown,
      Colors.purple,
      Colors.indigo,
      Colors.yellow,
      Colors.orange,
    ];

    return MaterialApp(
      title: 'Richard Li',
      home: Stack(
        children: [
          if (toggle.value)
            GridMorph(
              children: [
                for (Color color in colors) Container(color: color),
              ],
            )
          else
            DiscordInception(
              children: [
                for (Color color in colors) Container(color: color),
              ],
            ),
          ElevatedButton(
            child: const Text('Toggle'),
            onPressed: () {
              toggle.value = !toggle.value;
            },
          ).padding(all: 16),
        ],
      ),
    );
  }
}
