import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:accounting/core/constants/app_colors.dart';
import 'package:accounting/core/constants/enums/status.dart';
import 'package:accounting/core/navigation/app_router.dart';
import 'package:accounting/core/presentation/app_bloc_providers/app_bloc_providers.dart';
import 'package:accounting/core/presentation/bloc/network_info/network_info_bloc.dart';
import 'package:accounting/core/presentation/widget/toast_info.dart';
import 'package:accounting/core/theme/app_theme.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../core/di/injection.dart';


class AppWidget extends StatefulWidget {
  const AppWidget({super.key});
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final NetworkInfoBloc networkInfoBloc;
  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      networkInfoBloc = getIt<NetworkInfoBloc>();
      networkInfoBloc.stream.listen((state) {
        if (state.networkStatus) {
          toastInfo(
            msg: "Data connection is available.",
            status: Status.success,
          );
        } else {
          toastInfo(
            msg: "You are disconnected from the internet.",
            status: Status.error,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      networkInfoBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.primaryColor.withOpacity(0.4),
      ),
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: LoaderOverlay(
        overlayWidgetBuilder: (_) {
          return  Center(
            child: SpinKitCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        },
        child: MultiBlocProvider(
          providers: AppBlocProviders.allBlocProviders,
          child: ScreenUtilInit(
            designSize: const Size(375, 812),
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'stock',
              theme: getTheme(),
              routerConfig: AppRouteConfig.router,
            ),
          ),
        ),
      ),
    );
  }
}


