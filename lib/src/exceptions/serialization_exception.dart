/// Exception that is thrown when using the SerializerInterface failed to
/// de-/serialize a object
class SerializationException implements Exception {
  /// optional message to pass along
  final String? msg;

  /// Exception that is thrown when using the SerializerInterface failed to
  /// de-/serialize a object
  SerializationException([this.msg]);

  @override
  String toString() => '<SerializationException> $msg';
}
