import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import 'components/tabs.dart';
import 'pages/home.dart';
import 'pages/skill.dart';
import 'pages/skills.dart';
import 'pages/work.dart';
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
              int pathToFocused(String path) {
                if (path == '/') {
                  return 0;
                } else if (path.substring(0, 6) == '/works') {
                  return 2;
                } else if (path.substring(0, 7) == '/skills') {
                  return 1;
                } else {
                  throw Exception(path);
                }
              }

              return Column(
                children: [
                  Tabs(focusedTab: pathToFocused(state.fullpath!), tabs: tabs),
                  child.expanded(),
                ],
              ).material();
            },
            routes: [
              GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => CustomTransitionPage(
                        child: const Home(),
                        transitionsBuilder: (context, a, sa, child) => child,
                      ),
                  routes: [
                    GoRoute(
                      path: 'skills',
                      pageBuilder: (context, state) => CustomTransitionPage(
                        child: const Skills(),
                        transitionsBuilder: (context, a, sa, child) => child,
                      ),
                      routes: [
                        GoRoute(
                          path: ':name',
                          pageBuilder: (context, state) => CustomTransitionPage(
                            child: Skill(path: state.fullpath!),
                            transitionsBuilder: (context, a, sa, child) =>
                                child,
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'works',
                      pageBuilder: (context, state) => CustomTransitionPage(
                        child: const Works(),
                        transitionsBuilder: (context, a, sa, child) => child,
                      ),
                      routes: [
                        GoRoute(
                          path: ':name',
                          pageBuilder: (context, state) {
                            return CustomTransitionPage(
                              child:
                                  Work(path: 'works/${state.params['name']}'),
                              transitionsBuilder: (context, a, sa, child) =>
                                  child,
                            );
                          },
                        ),
                      ],
                    ),
                  ]),
            ],
          )
        ],
      ),
    );
  }
}
