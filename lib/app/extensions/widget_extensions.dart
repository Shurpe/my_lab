import 'package:flutter/widgets.dart';

extension WidgetPaddingExt on Widget {
  Widget withPaddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
}
