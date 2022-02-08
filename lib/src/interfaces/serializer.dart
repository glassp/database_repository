import '../deps.dart';

/// A interface for serialization for database storable objects
abstract class SerializerInterface<T extends DatabaseStorable> {
  /// serializes `element` into JSON
  JSON serialize(T element);

  /// deserializes a `json` into a [T] object
  T deserialize(JSON json);
}
