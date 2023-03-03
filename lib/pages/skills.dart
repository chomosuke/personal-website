import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

import '../components/grid_morph.dart';
import '../contents/get_paths.dart';
import 'skill.dart';

class Skills extends HookWidget {
  const Skills({
    super.key,
    required this.selected,
    required this.onSelectChange,
  });

  final Set<String> selected;
  final void Function(Set<String>) onSelectChange;

  @override
  Widget build(BuildContext context) {
    final paths = getPaths('skills');
    final selectedIndex = useState(ListQueue<int>());
    Set<String> selectedFromIndex(List<String> paths, Iterable<int> index) =>
        index.map((i) => paths[i % paths.length].substring(7)).toSet();

    useEffect(() {
      if (!setEquals(selectedFromIndex(paths, selectedIndex.value), selected)) {
        // change selectedIndex upon prop change
        final selectedIndexFromPath = ListQueue<int>();
        final visited = <String>{};
        for (var i = 0; i < paths.length; i++) {
          final name = paths[i].substring(7);
          if (selected.contains(name) && !visited.contains(name)) {
            selectedIndexFromPath.add(i);
          }
          visited.add(name);
        }
        selectedIndex.value = selectedIndexFromPath;
      }

      return null;
    });

    return GridMorph(
      childrenCount: paths.length,
      childFactory: (context, i, hovered) {
        final selected = selectedIndex.value.contains(i);
        return GridMorphChild(
          widget: Skill(
            path: paths[i % paths.length],
            state: selected ? SkillState.detailed : SkillState.iconText,
            onClose: () {
              selectedIndex.value.remove(i);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              selectedIndex.notifyListeners();
              onSelectChange(selectedFromIndex(paths, selectedIndex.value));
            },
          ).mouseRegion(
            cursor: selected ? MouseCursor.defer : SystemMouseCursors.click,
          ),
          selected: selected,
          onClick: () {
            if (!selectedIndex.value.contains(i)) {
              selectedIndex.value.addLast(i);
              while (selectedIndex.value.length > 3) {
                selectedIndex.value.removeFirst();
              }
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              selectedIndex.notifyListeners();
              onSelectChange(selectedFromIndex(paths, selectedIndex.value));
            }
          },
        );
      },
    );
  }
}
