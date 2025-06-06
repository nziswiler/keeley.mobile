import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/utils/alert_dialogs.dart';

extension AsyncValueUI on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    debugPrint('isLoading: $isLoading, hasError: $hasError');
    if (!isLoading && hasError) {
      final message = error.toString();
      showExceptionToast(
        context: context,
        title: 'Fehler',
        exception: message,
      );
    }
  }
}
