import 'dart:convert';

import 'package:flutter/services.dart';

abstract class SpanContent {}

class TextSpanContent extends SpanContent {
  TextSpanContent(this.text);
  final String text;
}

class LinkSpanContent extends SpanContent {
  LinkSpanContent(this.path);
  final String path;
}

class WorkContent {
  WorkContent({
    required this.name,
    // required this.screenshots,
    // required this.summary,
    // required this.description,
  });

  static Future<WorkContent> fromPath(String path) async {
    final text = await rootBundle.loadString('content/$path.md');
    final lines = const LineSplitter().convert(text);

    // final points = <String>[];
    // for (final line in lines.sublist(1)) {
    //   var work = line.substring(line.indexOf(']'));
    //   work = work.substring(3, work.length - 4);
    //   points.add(work);
    // }

    return WorkContent(
      name: lines[0].substring(2),
      // screenshots: [AssetImage('${path.substring(path.length - 3)}.png')],
    );
  }

  final String name;
  // final List<AssetImage> screenshots;
  // final String summary;
  // final String description;
}
