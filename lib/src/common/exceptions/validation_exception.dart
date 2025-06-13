import 'package:keeley/src/common/exceptions/app_exception.dart';

abstract class ValidationException extends AppException {
  const ValidationException(String? message, [this.errors]) : super(message);

  /// List of validation error messages
  final List<String>? errors;

  @override
  String toString() {
    final baseString = super.toString();
    if (errors != null && errors!.isNotEmpty) {
      return '$baseString\nValidation errors: ${errors!.join(', ')}';
    }
    return baseString;
  }
}
