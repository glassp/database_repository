import '../deps.dart';

/// A constraint that can be used with the where clauses
abstract class Constraint {
  /// The key on which the constraint should be applied on
  final String key;

  /// the value that is used when evaluating the constraint
  final dynamic value;

  /// Constructs a constraint which restricts what 
  Constraint({required this.key, required this.value});

  /// Check if the payload satisfies the [Constraint]
  bool evaluate(JSON payload);

  @override
  String toString() => "Constraint<$runtimeType on $key>(${value.toString()})";
}
