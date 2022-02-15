import '../deps.dart';


/// Checks if the element in question is a boolean and if it is false
class IsFalse extends Constraint {
  /// Checks if the element in question is a boolean and if it is false
  IsFalse({required String key}) : super(key: key, value: false);

  @override
  bool evaluate(JSON payload) => payload[key] is bool && !payload[key];
}

/// Checks if the element in question is falsey.
/// The following are falsey:
///  - an empty string
///  - an empty list
///  - an empty map
///  - 0
///  - false
///  - Error objects
///  - Exception objects
///  - null
class IsFalsey extends Constraint {
  /// Checks if the element in question is falsey.
  /// The following are falsey:
  ///  - an empty string
  ///  - an empty list
  ///  - an empty map
  ///  - 0
  ///  - false
  ///  - Error objects
  ///  - Exception objects
  ///  - null
  IsFalsey({required String key}) : super(key: key, value: false);

  @override
  bool evaluate(JSON payload) {
    final elem = payload[key];
    if (elem is String || elem is List || elem is Map) {
      return elem.isEmpty;
    }

    if (elem is num) {
      return elem == 0;
    }

    if (elem is bool) {
      return !elem;
    }

    if (elem is Error || elem is Exception) {
      return true;
    }

    return elem == null;
  }
}
