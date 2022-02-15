import '../deps.dart';

/// Checks if the element in question implements a constains function and if
/// given function returns true for value.
/// If value is iterable it will check for each element
class Contains extends Constraint {
  /// Checks if the element in question implements a constains function and if
  /// given function returns true for value.
  /// If value is iterable it will check for each element
  Contains({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      if (value is Iterable) {
        return value.every(payload[key].contains(value));
      }

      return payload[key].contains(value);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}

/// Checks if the element in question implements a constains function and if
/// given function returns false for value.
/// If value is iterable it will check for each element
class ContainsNot extends Constraint {
  /// Checks if the element in question implements a constains function and if
  /// given function returns false for value.
  /// If value is iterable it will check for each element
  ContainsNot({required String key, required value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) {
    try {
      return !payload[key].contains(value);
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return false;
    }
  }
}
