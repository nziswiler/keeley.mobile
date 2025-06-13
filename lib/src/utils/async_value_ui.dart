import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeley/src/utils/toasts.dart';
import 'package:keeley/src/constants/strings.dart';

extension AsyncValueUI on AsyncValue {
  void showExceptionToastOnError(BuildContext context) {
    if (!isLoading && hasError) {
      final message = error.toString();
      showExceptionToast(
        context: context,
        title: Strings.errorLoadingData,
        exception: message,
      );
    }
  }
}
