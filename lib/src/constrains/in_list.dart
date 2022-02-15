import '../deps.dart';

/// Checks if the element in question is in the provided list
class InList extends Constraint {

/// Checks if the element in question is in the provided list
  InList({required String key, required List<dynamic> value})
      : super(key: key, value: value);

  @override
  bool evaluate(JSON payload) => (value as List).contains(payload[key]);
}
