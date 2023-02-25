import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> getPaths(String folder) async {
  return const LineSplitter()
      .convert(await rootBundle.loadString('content/$folder/order.txt'))
      .map((line) => '$folder/$line')
      .toList();
}
