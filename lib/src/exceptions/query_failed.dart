import '../deps.dart';

class QueryFailedException implements Exception {
  final QueryResult queryResult;

  QueryFailedException(this.queryResult);

  @override
  String toString() {
    final errorMsg = queryResult.payload['ERROR'] ?? '';
    return "Query of type \"${queryResult.query.action.name}\" failed. \n $errorMsg";
  }
}
