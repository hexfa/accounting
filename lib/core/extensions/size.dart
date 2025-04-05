import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double widthPercentage(double percent) => screenWidth * percent;
  double heightPercentage(double percent) => screenHeight * percent;
}
