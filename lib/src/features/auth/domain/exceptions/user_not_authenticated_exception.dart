import 'package:keeley/src/common/exceptions/app_exception.dart';

class UserNotAuthenticatedException extends AppException {
  const UserNotAuthenticatedException([String? details])
      : super('User must be authenticated to perform this action', details);
}
