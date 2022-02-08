import '../deps.dart';

/// interface for objects that can be stored in a database
abstract class DatabaseStorable {
  /// Serialize object to JSON
  JSON toJson();

  /// The id for the Object.
  /// May be null if the object was not yet stored.
  /// The DatabaseAdapter should return an object containing an id.
  String? get id;

  /// It is assumed that objects with ids are managed.
  bool get isManaged => id != null;
}
