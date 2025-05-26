import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as ui;
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ui.SignInScreen(
      showAuthActionSwitch: true, // erlaubt Umschalten Login <-> Registrierung
      headerBuilder: (context, constraints, _) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            'Willkommen bei keeley',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        );
      },
      footerBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '© 2025 keeley AG – Alle Rechte vorbehalten',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        );
      },
      providers: [
        ui.EmailAuthProvider(), // Registrierung & Login werden durch UI geregelt
        ui.EmailLinkAuthProvider(
          actionCodeSettings: ActionCodeSettings(
            url: 'https://keeley.page.link/login',
            handleCodeInApp: true,
            androidPackageName: 'com.example.keeley',
            androidMinimumVersion: '21',
            androidInstallApp: true,
          ),
        ),
      ],
      actions: [
        ui.AuthStateChangeAction<ui.SignedIn>((context, state) {
          context.go('/dashboard');
        }),
      ],
    );
  }
}
