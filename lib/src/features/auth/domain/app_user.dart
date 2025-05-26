import 'package:keeley/src/features/entity_base.dart';

class AppUser extends EntityBase {
  AppUser({
    required this.email,
  });

  final String email;
}
