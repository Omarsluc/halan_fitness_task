import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/check_connection_service.dart';
import 'connection_dialog.dart';

class ConnectionWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onRetry;

  const ConnectionWrapper({
    super.key,
    required this.child,
    this.onRetry,
  });

  @override
  State<ConnectionWrapper> createState() => _ConnectionWrapperState();
}

class _ConnectionWrapperState extends State<ConnectionWrapper> {
  late InternetConnectivityService _connectivityService;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _connectivityService = InternetConnectivityService.instance;
    _connectivityService.startListening();

    // Listen to connection changes
    _connectivityService.isOffline.addListener(_onConnectionChanged);
  }

  @override
  void dispose() {
    _connectivityService.isOffline.removeListener(_onConnectionChanged);
    super.dispose();
  }

  void _onConnectionChanged() {
    if (_connectivityService.isOffline.value && !_isDialogShown) {
      _showConnectionDialog();
    } else if (!_connectivityService.isOffline.value && _isDialogShown) {
      _isDialogShown = false;
    }
  }

  void _showConnectionDialog() {
    if (!mounted) return;

    setState(() {
      _isDialogShown = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConnectionDialog(
        onRetry: () {
          _handleRetry();
        },
      ),
    ).then((_) {
      setState(() {
        _isDialogShown = false;
      });
    });
  }

  void _handleRetry() async {
    // Check connection again
    final hasConnection = await _connectivityService.checkConnection();
    if (hasConnection) {
      // Connection restored, call the retry callback if provided
      widget.onRetry?.call();
    } else {
      // Still no connection, show dialog again after a short delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted && !_connectivityService.isOffline.value) {
          _showConnectionDialog();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
