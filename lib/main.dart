import 'package:flutter/material.dart';
import 'package:accounting/core/shared/global_config.dart';
import 'package:accounting/core/presentation/app_widget.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfig.initConfig();
  runApp(AppWidget());

  



}



