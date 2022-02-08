import '../deps.dart';

/// Exception that is thrown when using [DatabaseRepository] utility methods
/// such as create and when the underlying [Query] failed
class QueryFailedException implements Exception {
  /// The query Result that failed.
  final QueryResult queryResult;

  /// Exception that is thrown when using [DatabaseRepository] utility methods
  /// such as create and when the underlying [Query] failed
  QueryFailedException(this.queryResult);

  @override
  String toString() {
    final errorMsg = queryResult.payload['ERROR'] ?? '';
    return "${queryResult.query} failed. \n $errorMsg";
  }
}
