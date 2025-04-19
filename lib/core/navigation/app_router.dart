import 'package:accounting/features/customers/presentation/pages/add_customer_page.dart';
import 'package:accounting/features/home/presentation/pages/home.dart';
import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:accounting/core/constants/app_strings.dart';
import 'package:accounting/core/shared/global_config.dart';
import 'package:accounting/features/application/presentation/pages/entry.dart';
import 'package:accounting/features/application/presentation/pages/splash.dart';

class AppRoutePath {
  static const String entryScreen = 'entry';
  static const String splashScreen = 'splash';
  static const String home = 'home';
  static const String addProduct = 'add-product';
  static const String addCustomer = 'add-customer';

}

GoRouter? globalGoRouter;

GoRouter getGoRouter() {
  return globalGoRouter ??= AppRouteConfig.router;
}

class AppRouteConfig {
  static final GoRouter router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutePath.entryScreen,
        builder: (BuildContext context, GoRouterState state) {
          entryFunction();
          return  EntryScreen();
        },
        routes: [
          GoRoute(
            path: AppRoutePath.splashScreen,
            name: AppRoutePath.splashScreen,
            builder: (BuildContext context, GoRouterState state) {
              return const SplashScreen();
            },
          ),
        ],
      ),
      GoRoute(
        path: "/${AppRoutePath.home}",
        name: AppRoutePath.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/${AppRoutePath.addCustomer}',
        name: AppRoutePath.addCustomer,
        builder: (context, state) => const AddCustomerPage(),
      ),
      GoRoute(
        path: "/${AppRoutePath.addProduct}",
        name: AppRoutePath.addProduct,
        builder: (context, state) {
          final product = state.extra as Product?;
          return AddProductPage(productToEdit: product);
        },
      ),
    ],
  );

  static Future<void> entryFunction() async {
    return Future.delayed(const Duration(seconds: 2), () {
      final bool isAppPreviouslyRan = GlobalConfig.storageService
          .getBoolValue(AppStrings.IS_APP_PREVIOUSLY_RAN);

      if (isAppPreviouslyRan) {
        AppRouteConfig.router.goNamed(AppRoutePath.home);
      } else {
        AppRouteConfig.router.goNamed(AppRoutePath.splashScreen);
      }
    });
  }

  static void clearAndNavigate(String path) {
    while (getGoRouter().canPop() == true) {
      getGoRouter().pop();
    }
    getGoRouter().pushReplacementNamed(path);
  }
}
