import 'dart:convert';
import 'package:flutter/services.dart';

import 'get_paths.dart';

final _skillContentMem = <String, SkillContent>{};

Future<void> populateSkills() async {
  final paths = getPaths('skills');
  for (final path in paths) {
    final text = await rootBundle.loadString('content/$path.md');
    final lines = const LineSplitter().convert(text);

    final works = <String>[];
    for (final line in lines.sublist(1)) {
      if (line.length >= 2 && line.substring(0, 2) == '- ') {
        var work = line.substring(line.indexOf(']'));
        work = work.substring(5, work.length - 4);
        works.add(work);
      }
    }

    String? iconPath;
    try {
      iconPath = 'content/assets/$path.svg.vec';
      await rootBundle.load(iconPath);
    // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      iconPath = 'content/assets/$path.png';
    }

    _skillContentMem[path] = SkillContent(
      name: lines[0].substring(2).replaceAll(r'\#', '#'),
      iconPath: iconPath,
      works: works,
      iconColor: Color(int.parse('66${lines[lines.length - 1]}', radix: 16)),
    );
  }
}

class SkillContent {
  SkillContent({
    required this.name,
    required this.iconPath,
    required this.works,
    required this.iconColor,
  });

  final String name;
  final String iconPath;
  final List<String> works;
  final Color iconColor;

  static SkillContent fromPath(String path) {
    return _skillContentMem[path]!;
  }
}
