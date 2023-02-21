import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import 'components/tabs.dart';
import 'pages/home.dart';
import 'pages/skills.dart';
import 'pages/works.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Richard Li',
      routerConfig: GoRouter(
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              final tabs = [
                TabElement(
                  child: const Text('Home', style: TextStyle(fontSize: 32)),
                  onTap: () {
                    context.go('/');
                  },
                ),
                TabElement(
                  child: const Text('Skills', style: TextStyle(fontSize: 32)),
                  onTap: () {
                    context.go('/skills');
                  },
                ),
                TabElement(
                  child: const Text('Works', style: TextStyle(fontSize: 32)),
                  onTap: () {
                    context.go('/works');
                  },
                ),
              ];
              final pathToFocuse = {'/': 0, '/skills': 1, '/works': 2};
              print('state.path: ${state.subloc}');
              print('state.path[]: ${pathToFocuse[state.subloc]}');
              return Column(
                children: [
                  Tabs(focusedTab: pathToFocuse[state.subloc]!, tabs: tabs),
                  child.expanded(),
                ],
              ).material();
            },
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const Home(),
              ),
              GoRoute(
                path: '/works',
                builder: (context, state) => const Works(),
              ),
              GoRoute(
                path: '/skills',
                builder: (context, state) => const Skills(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
