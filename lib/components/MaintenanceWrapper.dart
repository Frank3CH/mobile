import 'package:esmv_store/screens/MLMaintenanceScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:esmv_store/providers/maintenance_provider.dart';

/// Wrapper widget that checks maintenance status and shows maintenance screen if needed
class MaintenanceWrapper extends StatefulWidget {
  final Widget child;

  const MaintenanceWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MaintenanceWrapper> createState() => _MaintenanceWrapperState();
}

class _MaintenanceWrapperState extends State<MaintenanceWrapper> with WidgetsBindingObserver {
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
      builder: (context, maintenanceProvider, _) {
        if (maintenanceProvider.isUnderMaintenance) {
          return MLMaintenanceScreen(
            message: maintenanceProvider.maintenanceMessage,
            estimatedEndTime: maintenanceProvider.estimatedEndTime,
            onRetry: () {
              maintenanceProvider.checkMaintenanceStatus();
            },
          );
        }

        return widget.child;
      },
    );
  }
}