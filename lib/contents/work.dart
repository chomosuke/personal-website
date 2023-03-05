import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'get_paths.dart';
import 'quick_link_icons.dart';

abstract class SpanContent {}

class TextSpanContent extends SpanContent {
  TextSpanContent(this.text);
  final String text;
}

class BoldTextSpanContent extends SpanContent {
  BoldTextSpanContent(this.text);
  final String text;
}

class LinkSpanContent extends SpanContent {
  LinkSpanContent(this.text, this.path);
  final String text;
  final String path;
}

class ExternLinkSpanContent extends SpanContent {
  ExternLinkSpanContent(this.text, this.externLink);
  final String text;
  final String externLink;
}

class QuickLinkContent {
  QuickLinkContent(this.text, this.link, this.icon);
  final String text;
  final String link;
  final IconData? icon;
}

final _workContentMem = <String, WorkContent>{};

List<SpanContent> textToSpans(String text) {
  final textSpanStrs = text.split('](');
  final spans = <SpanContent>[];
  String? linkStr;
  for (var i = 0; i < textSpanStrs.length; i++) {
    var textSpanStr = textSpanStrs[i];
    if (linkStr != null) {
      var link = textSpanStr.substring(0, textSpanStr.indexOf(')'));
      if (link.substring(0, 9) == '../skills') {
        link = 'skills${link.substring(9, link.length - 3)}';
        spans.add(
          LinkSpanContent(
            linkStr,
            link,
          ),
        );
      } else if (link.substring(0, 2) == './') {
        link = '/works${link.substring(1, link.length - 3)}';
        spans.add(
          LinkSpanContent(
            linkStr,
            link,
          ),
        );
      } else {
        assert(link.substring(0, 4) == 'http');
        spans.add(
          ExternLinkSpanContent(
            linkStr,
            link,
          ),
        );
      }
      textSpanStr = textSpanStr.substring(textSpanStr.indexOf(')') + 1);
    }
    if (i < textSpanStrs.length - 1) {
      linkStr = textSpanStr.substring(textSpanStr.lastIndexOf('[') + 1);
      textSpanStr = textSpanStr.substring(0, textSpanStr.lastIndexOf('['));
    }

    // detect boldness
    final oddlyBold = textSpanStr.split('**');
    for (var j = 0; j < oddlyBold.length; j++) {
      if (j.isOdd) {
        spans.add(BoldTextSpanContent(oddlyBold[j]));
      } else {
        spans.add(TextSpanContent(oddlyBold[j]));
      }
    }
  }
  return spans;
}

Future<void> populateWorks() async {
  final paths = getPaths('works');
  for (final path in paths) {
    final text = await rootBundle.loadString('content/$path.md');
    final lines = const LineSplitter().convert(text);

    final descriptionLines = lines
        .sublist(lines.indexOf('## Description') + 1)
        .where((line) => line.length >= 2 && line.substring(0, 2) == '- ')
        .map((line) => line.substring(2))
        .toList();
    final description = descriptionLines.map(textToSpans).toList();

    final name = lines[0].substring(2);
    const shortNamePrefix = 'short name: ';
    final shortName = lines
        .firstWhere(
          (line) =>
              line.length > shortNamePrefix.length &&
              line.substring(0, shortNamePrefix.length) == shortNamePrefix,
          orElse: () => shortNamePrefix + name,
        )
        .substring(shortNamePrefix.length);

    final quickLinks =
        lines.where((line) => line.isNotEmpty && line[0] == '[').map((line) {
      final textLink = line.split('](');
      final text = textLink[0].substring(1);
      final link = textLink[1].substring(0, textLink[1].length - 1);
      return QuickLinkContent(
        text,
        link,
        quickLinkIcons[text],
      );
    }).toList();

    _workContentMem[path] = WorkContent(
      name: name,
      shortName: shortName,
      quickLinks: quickLinks,
      screenshot: AssetImage('content/assets/$path.png'),
      summary: lines[lines.indexOf('## Summary') + 1],
      description: description,
    );
  }
}

class WorkContent {
  WorkContent({
    required this.name,
    required this.shortName,
    required this.quickLinks,
    required this.summary,
    required this.screenshot,
    required this.description,
  });

  static WorkContent fromPath(String path) {
    return _workContentMem[path]!;
  }

  final String name;
  final String shortName;
  final List<QuickLinkContent> quickLinks;
  final String summary;
  final AssetImage screenshot;
  final List<List<SpanContent>> description;
}
