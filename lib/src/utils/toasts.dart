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
}) {
  final sonner = ShadSonner.of(context);
  sonner.show(
    ShadToast(
      title: Text("Yuuuhuu! Das hat funktioniert."),
      description: description != null ? Text(description) : null,
    ),
  );
}
