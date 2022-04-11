import '../deps.dart';

/// interface for objects that can be stored in a database
/// This class should also contain a from json constructor that allows to
/// construct via an empty json
abstract class DatabaseStorable {
  /// Serialize object to JSON
  JSON toJson();

  /// The id for the Object.
  /// May be null if the object was not yet stored.
  /// The DatabaseAdapter should return an object containing an id.
  String? get id;

  /// It is assumed that objects with ids are managed.
  bool get isManaged => id != null;

  /// The name of the  collection to use.
  /// Usually this will be the name of the runtime type.
  /// You may prefer to override this as dart the name of the runtime type
  /// may be a cryptic one if compiled for the web. E.g. minified:cI instead
  /// of User.
  String get collection => runtimeType.toString();
}
