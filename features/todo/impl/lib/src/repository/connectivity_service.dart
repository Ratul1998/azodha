import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  /// Network available (wifi/mobile)
  Future<bool> get hasNetwork async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  /// Real internet access check
  Future<bool> get hasInternet async {
    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ).timeout(const Duration(seconds: 3));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Combined check (what you should use)
  Future<bool> get isConnected async {
    return await hasNetwork && await hasInternet;
  }

  /// Emits TRUE only when internet is actually usable
  Stream<bool> get connectivityStream async* {
    await for (final _ in _connectivity.onConnectivityChanged) {
      yield await isConnected;
    }
  }
}
