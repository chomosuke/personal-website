import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SkillContent {
  SkillContent({
    required this.name,
    required this.icon,
    required this.works,
  });

  static Future<SkillContent> fromPath(String path) async {
    final text = await rootBundle.loadString('content/$path.md');
    final lines = const LineSplitter().convert(text);

    final works = <String>[];
    for (final line in lines.sublist(1)) {
      if (line.length >= 2 && line.substring(0, 2) == '- ') {
        var work = line.substring(line.indexOf(']'));
        work = work.substring(3, work.length - 4);
        works.add(work);
      }
    }

    return SkillContent(
      name: lines[0].substring(2).replaceAll(r'\#', '#'),
      icon: AssetImage('content/$path.png'),
      works: works,
    );
  }

  final String name;
  final AssetImage icon;
  final List<String> works;
}
