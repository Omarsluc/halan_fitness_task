import 'package:flutter/material.dart';
import '../widgets/connection_dialog.dart';
import 'check_connection_service.dart';

class ConnectionDialogService {
  static final ConnectionDialogService _instance =
      ConnectionDialogService._internal();
  factory ConnectionDialogService() => _instance;
  ConnectionDialogService._internal();

  /// Show connection dialog when there's no internet
  static Future<void> showConnectionDialog(
    BuildContext context, {
    VoidCallback? onRetry,
  }) async {
    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConnectionDialog(onRetry: onRetry),
    );
  }

  /// Check connection and show dialog if offline
  static Future<void> checkConnectionAndShowDialog(
    BuildContext context, {
    VoidCallback? onRetry,
  }) async {
    final connectivityService = InternetConnectivityService.instance;
    final hasConnection = await connectivityService.checkConnection();

    if (!hasConnection && context.mounted) {
      await showConnectionDialog(context, onRetry: onRetry);
    }
  }

  /// Show connection dialog with custom message
  static Future<void> showCustomConnectionDialog(
    BuildContext context, {
    required String title,
    required String message,
    VoidCallback? onRetry,
  }) async {
    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          if (onRetry != null)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetry();
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
