import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_snack_bar.dart';

class WhatsAppHelper {
  WhatsAppHelper._();

  static Future<void> openWhatsApp(
    String phoneNumber, {
    BuildContext? context,
    String? customMessage,
    String? errorMessage,
  }) async {
    var cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '2$cleanPhone';
    }

    final encodedMessage = customMessage != null
        ? Uri.encodeComponent(customMessage)
        : '';
    final urlString =
        'https://wa.me/$cleanPhone${encodedMessage.isNotEmpty ? "?text=$encodedMessage" : ""}';

    final uri = Uri.parse(urlString);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context != null && context.mounted) {
        _showErrorSnackBar(
          context,
          errorMessage ?? 'تعذر فتح تطبيق واتساب',
        );
      }
    } catch (_) {
      if (context != null && context.mounted) {
        _showErrorSnackBar(
          context,
          errorMessage ?? 'حدث خطأ أثناء فتح واتساب',
        );
      }
    }
  }

  static Future<void> launchCall(
    String phoneNumber, {
    BuildContext? context,
    String? errorMessage,
  }) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context != null && context.mounted) {
        _showErrorSnackBar(
          context,
          errorMessage ?? 'تعذر إجراء المكالمة',
        );
      }
    } catch (_) {
      if (context != null && context.mounted) {
        _showErrorSnackBar(
          context,
          errorMessage ?? 'حدث خطأ أثناء محاولة الاتصال',
        );
      }
    }
  }

  static void _showErrorSnackBar(BuildContext context, String message) {
    AppSnackBar.showError(context, message: message);
  }
}