import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _skillContentMem = <String, Future<SkillContent>>{};

class SkillContent {
  SkillContent({
    required this.name,
    required this.icon,
    required this.works,
    required this.iconColor,
  });

  final String name;
  final AssetImage icon;
  final List<String> works;
  final Color iconColor;

  static Future<SkillContent> fromPath(String path) {
    if (_skillContentMem[path] == null) {
      _skillContentMem[path] = () async {
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

        return SkillContent(
          name: lines[0].substring(2).replaceAll(r'\#', '#'),
          icon: AssetImage('content/assets/$path.png'),
          works: works,
          iconColor:
              Color(int.parse('66${lines[lines.length - 1]}', radix: 16)),
        );
      }();
    }
    return _skillContentMem[path]!;
  }
}
