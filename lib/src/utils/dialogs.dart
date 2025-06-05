import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
  bool isDestructive = false,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ShadTheme.of(context).alertDialogTheme.backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: ShadTheme.of(context).alertDialogTheme.radius!),
      title:
          Text(title, style: ShadTheme.of(context).alertDialogTheme.titleStyle),
      content: content != null
          ? Text(content,
              style: ShadTheme.of(context).alertDialogTheme.descriptionStyle)
          : null,
      actions: [
        if (cancelActionText != null)
          ShadButton.outline(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        isDestructive
            ? ShadButton.destructive(
                child: Text(defaultActionText),
                onPressed: () => Navigator.of(context).pop(true),
              )
            : ShadButton(
                child: Text(defaultActionText),
                onPressed: () => Navigator.of(context).pop(true),
              ),
      ],
    ),
  );
}
