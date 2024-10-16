import 'dart:async';

import 'package:brian_test/domain/layer_domain.dart';
import 'package:brian_test/ui/l10n/l10n_extensions.dart';
import 'package:brian_test/ui/main/controllers.dart';
import 'package:brian_test/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final domain = await LayerDomain.initAndInstance;

    FlutterError.onError = (details) {
      domain.recordError(details.exception, details.stack);
    };

    ErrorWidget.builder = (details) {
      domain.recordError(
        details.exception,
        details.stack,
      );

      return Container(
        color: Colors.grey,
      );
    };

    initControllers();

    runApp(const BrianTestApp());
  }, (error, stack) {
    LayerDomain.instance.recordError(error, stack, fatal: true);
  });
}

class BrianTestApp extends StatelessWidget {
  const BrianTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (c) => c.t.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: BrianTestRoutes.instance.routes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
