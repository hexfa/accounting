import 'package:accounting/core/constants/app_strings.dart';
import 'package:accounting/core/shared/global_config.dart';
import 'package:accounting/features/application/presentation/pages/entry.dart';
import 'package:accounting/features/application/presentation/pages/splash.dart';
import 'package:accounting/features/customers/domain/entities/customer.dart';
import 'package:accounting/features/customers/presentation/pages/add_customer_page.dart';
import 'package:accounting/features/customers/presentation/pages/customer_detail_page.dart';
import 'package:accounting/features/home/presentation/pages/home.dart';
import 'package:accounting/features/orders/domain/entities/customer_order.dart';
import 'package:accounting/features/orders/presentation/edit_order_page.dart';
import 'package:accounting/features/orders/presentation/pages/add_order_page.dart';
import 'package:accounting/features/products/domain/entities/product.dart';
import 'package:accounting/features/products/presentation/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutePath {
  static const String entryScreen = 'entry';
  static const String splashScreen = 'splash';
  static const String home = 'home';
  static const String addProduct = 'add-product';
  static const String addOrder = 'add-order';

  static const String addCustomer = 'add-customer';
  static const String editOrder = 'edit-order';
  static const String customerDetail = 'customer-detail';
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
        path: '/${AppRoutePath.customerDetail}',
        name: AppRoutePath.customerDetail,
        builder: (context, state) {
          final customer = state.extra as Customer;
          return CustomerDetailPage(customer: customer);
        },
      ),
      GoRoute(
        path: '/${AppRoutePath.addOrder}',
        name: AppRoutePath.addOrder,
        builder: (context, state) {
          final customer = state.extra as Customer;
          return AddOrderPage(customer: customer);
        },
      ),

      GoRoute(
        path: '/${AppRoutePath.addCustomer}',
        name: AppRoutePath.addCustomer,
        builder: (context, state) => const AddCustomerPage(),
      ),
      GoRoute(
        path: '/${AppRoutePath.editOrder}',
        name: AppRoutePath.editOrder,
        builder: (context, state) {
          final order = state.extra as CustomerOrder;
          return EditOrderPage(order: order);
        },
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
