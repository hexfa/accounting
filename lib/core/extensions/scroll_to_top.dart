import 'package:flutter/material.dart';

extension ScrollControllerExtension on ScrollController {
  void scrollToTop() {
    animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}
