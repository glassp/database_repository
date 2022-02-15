import '../deps.dart';

/// Checks if the element in question implements a > operator and if
/// given operator returns true for value.
class GreaterThan extends Constraint {
  /// Checks if the element in question implements a > operator and if
  /// given operator returns true for value.
  GreaterThan({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      return payload[key] > value;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}

/// Checks if the element in question implements a >= operator and if
/// given operator returns true for value.
class GreaterThanOrEquals extends Constraint {
  /// Checks if the element in question implements a >= operator and if
  /// given operator returns true for value.
  GreaterThanOrEquals({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      return payload[key] >= value;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
