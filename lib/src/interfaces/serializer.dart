import '../deps.dart';

/// A interface for serialization for database storable objects
abstract class SerializerInterface<T extends DatabaseStorable> {
  /// serializes `element` into JSON
  JSON serialize(T element);

  /// deserializes a `json` into a [T] object.
  /// A empty json should also yield a correct object.
  T deserialize(JSON json);

  /// constructs a new T object from an empty json
  T construct() {
    try {
      return deserialize({});
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      throw SerializationException(
        'Could not construct object using empty json!',
      );
    }
  }
}
