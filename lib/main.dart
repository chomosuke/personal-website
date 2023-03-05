import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:styled_widget/styled_widget.dart';

import 'contents/get_paths.dart';
import 'contents/skill.dart';
import 'contents/work.dart';
import 'pages/home/home.dart';
import 'pages/skill/skills.dart';
import 'pages/work/work.dart';
import 'pages/work/works.dart';
import 'styles.dart';
import 'tabs.dart';

void main() {
  runApp(const App());
}

class App extends HookWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final loading = useFuture(
      useMemoized(() async {
        await populatePaths();
        await populateSkills();
        await populateWorks();
        return 1;
      }),
    );

    Page<dynamic> Function(BuildContext context, GoRouterState state)
        pageBuilder(
      Widget Function(BuildContext context, GoRouterState state) childFactory,
    ) {
      return (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            child: childFactory(context, state),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(
                opacity: animation,
                child: (!loading.hasData
                        ? const Text('loading...').center()
                        : child)
                    .backgroundColor(Colors.white),
              );
            },
          );
    }

    return Portal(
      child: loading.hasError
          ? Text(
              loading.error.toString() + loading.stackTrace.toString(),
              textDirection: TextDirection.ltr,
            )
          : MaterialApp.router(
              title: 'Richard Li',
              routerConfig: GoRouter(
                initialLocation: Uri.base
                    .toString()
                    .replaceFirst(Uri.base.origin, '')
                    .replaceFirst('/#', ''),
                routes: [
                  ShellRoute(
                    builder: (context, state, child) {
                      final tabs = [
                        TabElement(
                          childFactory: (animation) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset('content/assets/house.svg'),
                                  SvgPicture.asset(
                                    'content/assets/house-fill.svg',
                                  ).opacity(animation),
                                ],
                              )
                                  .constrained(width: 45, height: 45)
                                  .padding(right: 4),
                              Text('home', style: heading2.textStyle),
                            ],
                          ),
                          onTap: () => context.go('/'),
                        ),
                        TabElement(
                          childFactory: (animation) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset('content/assets/brain.svg'),
                                  SvgPicture.asset(
                                    'content/assets/brain-fill.svg',
                                  ).opacity(animation),
                                ],
                              )
                                  .constrained(width: 45, height: 45)
                                  .padding(right: 4),
                              Text('skills', style: heading2.textStyle),
                            ],
                          ),
                          onTap: () => context.go('/skills'),
                        ),
                        TabElement(
                          childFactory: (animation) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'content/assets/briefcase.svg',
                                  ),
                                  SvgPicture.asset(
                                    'content/assets/briefcase-fill.svg',
                                  ).opacity(animation),
                                ],
                              )
                                  .constrained(width: 45, height: 45)
                                  .padding(right: 4),
                              Text('works', style: heading2.textStyle),
                            ],
                          ),
                          onTap: () => context.go('/works'),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Tabs(
                            focusedTab: pathToFocused(state.fullpath!),
                            tabs: tabs,
                          ),
                          child.expanded(),
                        ],
                      ).material();
                    },
                    routes: [
                      GoRoute(
                        path: '/',
                        pageBuilder:
                            pageBuilder((context, state) => const Home()),
                        routes: [
                          GoRoute(
                            path: 'skills',
                            pageBuilder: pageBuilder(
                              (context, state) => Skills(
                                selected: state.queryParams['selected']
                                        ?.split(',')
                                        .toSet() ??
                                    {},
                                onSelectChange: (selected) => context.go(
                                  '/skills?selected=${selected.join(',')}',
                                ),
                              ),
                            ),
                          ),
                          GoRoute(
                            path: 'works',
                            pageBuilder: pageBuilder(
                              (context, state) => const Works(),
                            ),
                            routes: [
                              GoRoute(
                                path: ':name',
                                pageBuilder: pageBuilder(
                                  (context, state) => Work(
                                    path: 'works/${state.params['name']}',
                                    showDetail: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
