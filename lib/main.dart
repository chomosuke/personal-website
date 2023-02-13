import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'discord_inception.dart';

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
      home: toggle.value
          ? DiscordInception(
              children: [
                for (Color color in colors) Container(color: color),
              ],
            )
          : const Center(),
    );
  }
}
