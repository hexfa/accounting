import 'package:flutter/material.dart';

enum DeviceScreenType { mobile, tablet, desktop }
DeviceScreenType getDeviceType(BoxConstraints constraints) {
  final width = constraints.maxWidth;
  if (width >= 1000) {
    return DeviceScreenType.desktop;
  } else if (width >= 600) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.mobile;
  }
}
