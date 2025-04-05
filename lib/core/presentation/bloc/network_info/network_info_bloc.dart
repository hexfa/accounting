import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:accounting/core/shared/utilities/network_info.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_info_event.dart';

part 'network_info_state.dart';

@injectable
class NetworkInfoBloc extends Bloc<NetworkInfoEvent, NetworkInfoState> {
  final NetworkInfo networkInfo;
  final Connectivity connectivity;
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  NetworkInfoBloc({
    required this.networkInfo,
    required this.connectivity,
  }) : super(NetworkInfoState(networkStatus: true)) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
    }

    on<CheckNetwork>(
      _onCheckNetwork,
      transformer: debounce(
        const Duration(seconds: 2),
      ),
    );

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((connectivityResultList) async {
          await Future.delayed(const Duration(seconds: 1)); // Small delay
          debugPrint('Connectivity Result after delay: $connectivityResultList');
          add(CheckNetwork());
        });
  }

  Future<void> _onCheckNetwork(
      CheckNetwork event,
      Emitter<NetworkInfoState> emit,
      ) async {
    final isConnected = await networkInfo.isConnected;
    if (state.networkStatus != isConnected) {
      emit(NetworkInfoState(networkStatus: isConnected));
    }
    debugPrint(
        'Network Status ==> ${isConnected ? "Data connection is available." : "You are disconnected from the internet."}');
  }

  @override
  Future<void> close() {
    connectivitySubscription.cancel();
    return super.close();
  }
}