import '../deps.dart';

/// Checks if the element in question is a boolean and if it is false
class IsTrue extends Constraint {
  /// Checks if the element in question is a boolean and if it is false
  IsTrue({required String key}) : super(key: key, value: true);

  @override
  bool evaluate(JSON payload) => payload[key] is bool && payload[key];
}

/// Checks if the element in question is truthy.
/// The following are falsey:
///  - a non-empty string
///  - a non-empty list
///  - a non-empty map
///  - any number other than 0
///  - true
///  - any object other than Error
///  - any object other than Exception
///  - any object other thatn null
class IsTruthy extends Constraint {
  /// Checks if the element in question is truthy.
  /// The following are falsey:
  ///  - a non-empty string
  ///  - a non-empty list
  ///  - a non-empty map
  ///  - any number other than 0
  ///  - true
  ///  - any object other than Error
  ///  - any object other than Exception
  ///  - any object other thatn null
  IsTruthy({required String key}) : super(key: key, value: true);

  @override
  bool evaluate(JSON payload) {
    final elem = payload[key];
    if (elem is String || elem is List || elem is Map) {
      return elem.isNotEmpty;
    }

    if (elem is num) {
      return elem != 0;
    }

    if (elem is bool) {
      return elem;
    }

    if (elem is Error || elem is Exception) {
      return false;
    }

    return elem != null;
  }
}
