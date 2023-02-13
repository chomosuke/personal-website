import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const App());
}

class Page {
  final String title;
  Page(this.title);
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Richard Li',
        home: Navigator(
          pages: [
            MaterialPage(
              key: const ValueKey('home'),
              child: Scaffold(
                  appBar: AppBar(
                title: const Text("Richard Li's personal website."),
              )),
            ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        ),
      );
}
