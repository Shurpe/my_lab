import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
export 'widget_extensions.dart';
extension IntExtensions on int {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
