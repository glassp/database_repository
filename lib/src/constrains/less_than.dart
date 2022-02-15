import '../deps.dart';

/// Checks if the element in question implements a < operator and if
/// given operator returns true for value.
class LessThan extends Constraint {
  /// Checks if the element in question implements a < operator and if
  /// given operator returns true for value.
  LessThan({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      return payload[key] < value;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}

/// Checks if the element in question implements a <= operator and if
/// given operator returns true for value.
class LessThanOrEquals extends Constraint {
  /// Checks if the element in question implements a <= operator and if
  /// given operator returns true for value.
  LessThanOrEquals({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      return payload[key] <= value;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
