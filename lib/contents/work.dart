import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'get_paths.dart';

abstract class SpanContent {}

class TextSpanContent extends SpanContent {
  TextSpanContent(this.text);
  final String text;
}

class LinkSpanContent extends SpanContent {
  LinkSpanContent(this.path);
  final String path;
}

final _workContentMem = <String, WorkContent>{};

Future<void> populateWorks() async {
  final paths = getPaths('works');
  for (final path in paths) {
    final text = await rootBundle.loadString('content/$path.md');
    final lines = const LineSplitter().convert(text);

    // final points = <String>[];
    // for (final line in lines.sublist(1)) {
    //   var work = line.substring(line.indexOf(']'));
    //   work = work.substring(3, work.length - 4);
    //   points.add(work);
    // }
    _workContentMem[path] = WorkContent(
      name: lines[0].substring(2),
      screenshot: AssetImage('content/assets/$path.png'),
    );
  }
}

class WorkContent {
  WorkContent({
    required this.name,
    required this.screenshot,
    // required this.summary,
    // required this.description,
  });

  static WorkContent fromPath(String path) {
    return _workContentMem[path]!;
  }

  final String name;
  final AssetImage screenshot;
  // final String summary;
  // final String description;
}
