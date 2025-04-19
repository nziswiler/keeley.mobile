import 'package:uuid/uuid.dart';

abstract class EntityBase {
  late final String id;
  late final DateTime createdOn;
  late final String createdBy;
  DateTime? modifiedOn;
  String? modifiedBy;

  EntityBase() {
    id = Uuid().v4();
  }
}
