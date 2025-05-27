part of 'alert_dialogs.dart';

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
