import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:accounting/core/data/storage_services/secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../constants/app_strings.dart';
import '../data/storage_services/shared_prefs_storage_service.dart';
import '../di/injection.dart';

class GlobalConfig {
  static late SharedPrefsStorageService storageService;
  static final secureStorage = getIt<SecureStorage>();

  static Future<void> initConfig() async {

    configureDependencies(Environment.prod);
    storageService = await SharedPrefsStorageService().init();

    try {
      await dotenv.load(fileName: "token_holder.env");
      final token = dotenv.env[AppStrings.API_TOKEN];
      if (token == null || token.isEmpty) {
        throw Exception("API_TOKEN is missing in .env file");
      }
      await secureStorage.saveToken(token);

    } catch (e) {
      debugPrint("Error during GlobalConfig initialization: $e");
      throw Exception("Error during GlobalConfig initialization: $e");
    }
  }
}

