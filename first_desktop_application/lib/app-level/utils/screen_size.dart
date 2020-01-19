import 'package:flutter/material.dart' show BuildContext, MediaQuery;

class ScreenQueries {
  ScreenQueries._privateConstructor();

  /// GENERIC INSTANCE OF ScreenQueries CLASS.....
  static final instance = ScreenQueries._privateConstructor();

  /// Get the width of the device...
  double width(BuildContext context) => MediaQuery.of(context).size.width;

  /// Get the height of the device...
  double height(BuildContext context) => MediaQuery.of(context).size.height;

  /// App's generic dimension...
  double genericDimension(BuildContext context) =>
      MediaQuery.of(context).size.width / 4;
}
