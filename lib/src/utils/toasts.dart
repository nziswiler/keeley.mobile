import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keeley/src/theme/keeley_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void showExceptionToast({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) {
  final sonner = ShadSonner.of(context);
  sonner.show(
    ShadToast.destructive(
      title: Text(title),
      description: Text(_message(exception)),
    ),
  );
}

String _message(dynamic exception) {
  if (exception is FirebaseException) {
    return exception.message ?? exception.toString();
  }
  if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  }
  return exception.toString();
}

void showSuccessToast({
  required BuildContext context,
  String? description,
  String? title,
}) {
  final theme = ShadTheme.of(context);
  final sonner = ShadSonner.of(context);

  sonner.show(
    ShadToast(
      title: Text(
        title ?? "Yuuhuu! Das hat funktioniert.",
      ),
      description: description != null ? Text(description) : null,
      action: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: (theme.colorScheme as KeeleyColorScheme).income,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_rounded,
          size: 18,
          color: (theme.colorScheme as KeeleyColorScheme).incomeForeground,
        ),
      ),
    ),
  );
}
