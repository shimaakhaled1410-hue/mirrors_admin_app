import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AdminProductionView extends StatelessWidget {
  const AdminProductionView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProduction),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}