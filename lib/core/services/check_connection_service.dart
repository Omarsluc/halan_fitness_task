import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class InternetConnectivityService {
  InternetConnectivityService._internal();

  static final InternetConnectivityService instance =
      InternetConnectivityService._internal();

  factory InternetConnectivityService() => instance;

  List<ConnectivityResult>? connectionStatus;
  final Connectivity connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  ValueNotifier<bool> isOffline = ValueNotifier(false);

  /// Starts listening to internet connection changes
  void startListening() {
    // Check initial connection status
    _checkInitialConnection();

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Check initial connection status
  Future<void> _checkInitialConnection() async {
    try {
      final result = await connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      developer.log('Error checking initial connectivity: $e');
    }
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    connectionStatus = result;
    isOffline.value = connectionStatus!.contains(ConnectivityResult.none);

    developer.log("${isOffline.value}");

    developer.log('Connectivity changed: $connectionStatus');
  }

  /// Manually check current connection status
  Future<bool> checkConnection() async {
    try {
      final result = await connectivity.checkConnectivity();
      return !result.contains(ConnectivityResult.none);
    } catch (e) {
      developer.log('Error checking connectivity: $e');
      return false;
    }
  }

  /// Stops listening to network changes and prevents memory leaks
  void dispose() {
    connectivitySubscription?.cancel();
    connectivitySubscription = null;
  }
}
