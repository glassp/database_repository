import '../deps.dart';

/// Checks if the element in question is equal to the given value
class Equals extends Constraint {
  /// Checks if the element in question is equal to the given value
  Equals({required String key, required value}) : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) =>
      payload.containsKey(key) && payload[key] == value;
}

/// Checks if the element in question is not equal to the given value
class NotEquals extends Constraint {
  /// Checks if the element in question is equal to the given value
  NotEquals({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) =>
      payload.containsKey(key) && payload[key] != value;
}
