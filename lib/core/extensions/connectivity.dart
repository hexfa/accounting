
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

extension ConnectivityExtension on BuildContext {
  Future<bool> get isConnected async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
