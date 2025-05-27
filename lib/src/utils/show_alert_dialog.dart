part of 'alert_dialogs.dart';

Future<bool?> showAlertDialog({
  required BuildContext context,
  required String title,
  String? content,
  String? cancelActionText,
  required String defaultActionText,
  bool isDestructive = false,
}) async {
  return showShadDialog<bool>(
    context: context,
    builder: (context) => ShadDialog(
      title: Text(title),
      description: content != null ? Text(content) : null,
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
