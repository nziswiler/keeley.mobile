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
  ShadSonner.of(context).show(
    ShadToast.destructive(
      title: Text(title),
      description: Text(_getExceptionMessage(exception)),
    ),
  );
}

String _getExceptionMessage(dynamic exception) {
  return switch (exception) {
    FirebaseException e => e.message ?? e.toString(),
    PlatformException e => e.message ?? e.toString(),
    _ => exception.toString(),
  };
}

void showSuccessToast({
  required BuildContext context,
  String? description,
  String? title,
}) {
  final colorScheme = ShadTheme.of(context).colorScheme as KeeleyColorScheme;

  ShadSonner.of(context).show(
    ShadToast(
      title: Text(title ?? "Yuuhuu! Das hat funktioniert."),
      description: description != null ? Text(description) : null,
      action: _buildSuccessIcon(colorScheme),
    ),
  );
}

Widget _buildSuccessIcon(KeeleyColorScheme colorScheme) {
  return Container(
    width: 32,
    height: 32,
    decoration: BoxDecoration(
      color: colorScheme.income,
      shape: BoxShape.circle,
    ),
    child: Icon(
      Icons.check_rounded,
      size: 18,
      color: colorScheme.incomeForeground,
    ),
  );
}
