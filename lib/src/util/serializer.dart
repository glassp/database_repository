import '../deps.dart';

/// A Serializer that takes a fromJson constructor and used it for
/// deserialization.
class Serializer<T extends DatabaseStorable> extends SerializerInterface<T> {
  /// The constructor that takes a JSON object and returns a [T] object
  final T Function(JSON) constructor;

  /// A Serializer that takes a fromJson constructor and used it for
  /// deserialization.
  Serializer(this.constructor);

  @override
  JSON serialize(T element) {
    try {
      return element.toJson();
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      throw SerializationException();
    }
  }

  @override
  T deserialize(JSON json) {
    try {
      return constructor(json);
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      throw SerializationException();
    }
  }
}
