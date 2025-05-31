abstract class AppException implements Exception {
  const AppException(this.message, [this.details]);

  final String message;
  final String? details;

  @override
  String toString() {
    if (details != null) {
      return '$runtimeType: $message\nDetails: $details';
    }
    return '$runtimeType: $message';
  }
}
