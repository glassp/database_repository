import '../deps.dart';

/// Checks if the element in question is null
/// IMPORTANT: to check if a key is not set use [IsUnset]
class IsNull extends Constraint {
  /// Checks if the element in question is null
  /// IMPORTANT: to check if a key is not set use [IsUnset]
  IsNull({required String key}) : super(key: key, value: null);

  @override
  bool evaluate(JSON payload) =>
      payload.containsKey(key) && payload[key] == null;
}

/// Checks if the element in question is not null
/// IMPORTANT: to check if a key is not set use [IsSet]
class IsNotNull extends Constraint {
  /// Checks if the element in question is not null
  /// IMPORTANT: to check if a key is not set use [IsSet]
  IsNotNull({required String key}) : super(key: key, value: null);

  @override
  bool evaluate(JSON payload) =>
      payload.containsKey(key) && payload[key] != null;
}
