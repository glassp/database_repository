class QueryFailedException implements Exception {
    final QueryResult queryResult;

    QueryFailedException(this.queryResult);

    String toString() {
        const errorMsg = queryResult.payload['ERROR'] ?? '';
        return "Query of type \"${queryResult.query.action.name}\" failed. \n $errorMsg";
    }
}