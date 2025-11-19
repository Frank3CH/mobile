import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MLMaintenanceScreen extends StatefulWidget {
  final String? message;
  final String? message2;
  final String? estimatedEndTime;
  final VoidCallback? onRetry;

  const MLMaintenanceScreen({
    Key? key,
    this.message,
    this.message2,
    this.estimatedEndTime,
    this.onRetry,
  }) : super(key: key);

  @override
  State<MLMaintenanceScreen> createState() => _MLMaintenanceScreenState();
}

class _MLMaintenanceScreenState extends State<MLMaintenanceScreen> {
  bool _isRetrying = false;

  Future<void> _handleRetry() async {
    if (_isRetrying) return;

    setState(() {
      _isRetrying = true;
    });

    widget.onRetry?.call();

    // Reset loading state after a short delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isRetrying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.construction_rounded,
                  size: 75,
                  color: context.primaryColor,
                ),
                24.height,
                Text(
                  'Maintenance en cours',
                  style: boldTextStyle(size: 24),
                  textAlign: TextAlign.center,
                ),
                16.height,
                Text(
                  widget.message ??
                      'We\'re currently performing maintenance to improve your experience. Please check back soon.',
                  style: secondaryTextStyle(size: 16),
                  textAlign: TextAlign.center,
                ),
                16.height,
                Text(
                  widget.message2 ??
                      'نحن نقوم حالياً بأعمال صيانة لتحسين تجربتك. يرجى العودة قريباً.',
                  style: secondaryTextStyle(size: 16),
                  textAlign: TextAlign.center,
                ),
                if (widget.estimatedEndTime != null) ...[
                  16.height,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Prévu pour être de retour le: ${widget.estimatedEndTime}',
                      style: primaryTextStyle(size: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                32.height,
                AppButton(
                  text: _isRetrying ? 'Verification...' : 'Re-verifiez',
                  onTap: _isRetrying ? null : _handleRetry,
                  color: context.primaryColor,
                  width: context.width() * 0.5,
                  child: _isRetrying
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                      : null,
                ),
                16.height,
                Text(
                  'Nous vous prions de nous excuser pour ce désagrément',
                  style: secondaryTextStyle(size: 12, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}