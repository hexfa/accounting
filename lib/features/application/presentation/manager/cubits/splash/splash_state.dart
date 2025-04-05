import 'package:flutter/widgets.dart';
import 'package:accounting/features/application/domain/entities/splash/splash_item.dart';
import 'package:accounting/features/application/presentation/widgets/single_splash_page.dart';

class SplashState {
  final int currentSplashIndex;
  final List<Widget> pages;

  SplashState({
    required this.currentSplashIndex,
    required this.pages,
  });

  factory SplashState.initial() {
    return SplashState(
      currentSplashIndex: 0,
      pages: splashItems
          .map((splashItem) => singleSplashPage(splashItem: splashItem))
          .toList(),
    );
  }

  SplashState copyWith({
    int? currentSplashIndex,
    List<Widget>? pages,
  }) {
    return SplashState(
      currentSplashIndex: currentSplashIndex ?? this.currentSplashIndex,
      pages: pages ?? this.pages,
    );
  }
}
