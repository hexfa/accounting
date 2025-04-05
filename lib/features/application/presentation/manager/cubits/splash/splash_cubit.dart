import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:accounting/core/constants/app_strings.dart';
import 'package:accounting/core/shared/global_config.dart';
import 'package:accounting/core/navigation/app_router.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final PageController pageController;
  final BuildContext context;

  SplashCubit({
    required this.pageController,
    required this.context,
  }) : super(SplashState.initial());

  // set current page
  set currentPage(int value) {
    emit(state.copyWith(currentSplashIndex: value));
  }

  // next slide
  void next() {
    pageController.animateToPage(
      state.currentSplashIndex + 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  // launch app
  void launch() {
    GlobalConfig.storageService.setBoolValue(
      AppStrings.IS_APP_PREVIOUSLY_RAN,
      true,
    );
    context.pushReplacementNamed(AppRoutePath.home);
  }

  // skip slides
  void skip() {
    pageController.animateToPage(
      state.pages.length - 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }
}
