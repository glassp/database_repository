import '../deps.dart';

/// An Exception indicating that a given [Constraint] is not supported for the
/// given [DatabaseAdapter]
class ConstraintUnsupportedException implements Exception {
  /// The constraint that failed
  final Constraint constraint;

  /// The DatabaseAdapter that does not support the [Constraint]
  final DatabaseAdapter adapter;

  /// An Exception indicating that a given [Constraint] is not supported for the
  /// given [DatabaseAdapter]
  ConstraintUnsupportedException({
    required this.constraint,
    required this.adapter,
  });

  @override
  String toString() => "Constraint ${constraint.runtimeType} is not "
      "supported for Adapter ${adapter.name}";
}
