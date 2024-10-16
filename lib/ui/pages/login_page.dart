import 'package:brian_test/ui/controllers/auth_controller.dart';
import 'package:brian_test/ui/l10n/l10n_extensions.dart';
import 'package:brian_test/ui/main/pages.dart';
import 'package:brian_test/ui/main/routes.dart';
import 'package:brian_test/ui/main/spaces.dart';
import 'package:brian_test/ui/ui_extensions.dart';
import 'package:brian_test/ui/utils/loading_dialog.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = AuthController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 150),
            AppSpaces.widget.h50(),
            Text(
              context.t.loginWelcome,
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpaces.widget.h100(),
            Text(
              context.t.loginSocialNetwork,
              style: const TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            AppSpaces.widget.h20(),
            IconButton(
              onPressed: () => _onSocialLoginClick(context),
              icon: Image.network(
                'http://pngimg.com/uploads/google/google_PNG19635.png',
                width: 40.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSocialLoginClick(BuildContext context) {
    DialogLoading.show(
      context: context,
      process: controller.loginSocialNetwork(),
    ).then((value) {
      if (value == null) {
        // ignore: use_build_context_synchronously
        context.replace(BrianTestPage.home);
      } //
      else {
        // ignore: use_build_context_synchronously
        context.showSnackBar(value);
      }
    });
  }
}
