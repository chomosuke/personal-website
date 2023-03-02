import 'dart:convert';

import 'package:flutter/services.dart';

final _paths = <String, List<String>>{};

Future<void> populatePaths() async {
  for (final folder in ['works', 'skills']) {
    _paths[folder] = const LineSplitter()
        .convert(await rootBundle.loadString('content/$folder/order.txt'))
        .map((line) => '$folder/$line')
        .toList();
  }
}

List<String> getPaths(String folder) {
  return _paths[folder]!;
}
