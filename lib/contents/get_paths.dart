import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> getPaths(String folder) async {
  final list = (jsonDecode(
    await rootBundle.loadString('AssetManifest.json'),
  ) as Map<String, dynamic>)
      .keys;
  return list
      .where((String k) => k.contains('content/$folder/'))
      .where((String k) => k.contains('.md'))
      .map(
        (String skillPath) => skillPath.substring(8, skillPath.length - 3),
      )
      .toList();
}
