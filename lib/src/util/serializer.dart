import '../deps.dart';

/// A Serializer that takes a fromJson constructor and used it for deserialization.
class Serializer<T extends DatabaseStorable> implements SerializerInterface<T> {
  /// The constructor that takes a JSON object and returns a [T] object
  final T Function(JSON) constructor;

  /// A Serializer that takes a fromJson constructor and used it for deserialization.
  Serializer(this.constructor);

  @override
  JSON serialize(T element) => element.toJson();

  @override
  T deserialize(JSON json) => constructor(json);
}
