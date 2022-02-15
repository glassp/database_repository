import '../deps.dart';

/// Checks if the element in question is set.
/// IMPORANT: The value may be null.
/// To check if it is set and not null use [IsNotNull].
class IsSet extends Constraint {
  /// Checks if the element in question is set.
  /// IMPORANT: The value may be null.
  /// To check if it is set and not null use [IsNotNull].
  IsSet({required String key}) : super(key: key, value: null);

  @override
  bool evaluate(JSON payload) => payload.containsKey(key);
}

/// Checks if the element in question is unset.
class IsUnset extends Constraint {
  /// Checks if the element in question is unset.
  IsUnset({required String key}) : super(key: key, value: null);

  @override
  bool evaluate(JSON payload) => !payload.containsKey(key);
}
