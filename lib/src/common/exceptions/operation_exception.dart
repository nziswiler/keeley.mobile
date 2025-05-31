import 'package:keeley/src/common/exceptions/app_exception.dart';

abstract class OperationException extends AppException {
  const OperationException(super.message, [super.details, this.cause]);

  /// The underlying cause of the exception, if any
  final Exception? cause;

  @override
  String toString() {
    final baseString = super.toString();
    if (cause != null) {
      return '$baseString\nCaused by: $cause';
    }
    return baseString;
  }
}
