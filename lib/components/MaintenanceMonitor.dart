import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/providers/maintenance_provider.dart';
import 'package:esmv_store/screens/MLMaintenanceScreen.dart';

/// Alternative approach: Monitors maintenance status and forces full-screen overlay
class MaintenanceMonitor extends StatefulWidget {
  final Widget child;

  const MaintenanceMonitor({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MaintenanceMonitor> createState() => _MaintenanceMonitorState();
}

class _MaintenanceMonitorState extends State<MaintenanceMonitor> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Start periodic checks when widget is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MaintenanceProvider>().startPeriodicCheck();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Check maintenance status when app comes to foreground
    if (state == AppLifecycleState.resumed) {
      context.read<MaintenanceProvider>().checkMaintenanceStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MaintenanceProvider>(
      builder: (context, maintenanceProvider, child) {
        // Use Stack to overlay maintenance screen on top of everything
        return Stack(
          children: [
            widget.child,
            if (maintenanceProvider.isUnderMaintenance)
              Positioned.fill(
                child: MLMaintenanceScreen(
                  message: maintenanceProvider.maintenanceMessage,
                  estimatedEndTime: maintenanceProvider.estimatedEndTime,
                  onRetry: () {
                    maintenanceProvider.checkMaintenanceStatus();
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}