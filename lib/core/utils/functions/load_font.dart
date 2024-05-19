import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

Future<pw.Font> loadFont(String path) async {
  final fontData = await rootBundle.load(path);
  return pw.Font.ttf(fontData);
}
