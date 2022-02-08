import '../deps.dart';

/// The result of a [Query]
class QueryResult {
    /// The original [Query] that yielded this QueryResult
    final Query query;

    /// If the [Query] was successful
    final bool wasSuccessful;

    /// May contain a payload json if the [Query] was successful or an object containing an ERROR key with the message
    final JSON payload;

    QueryResult._(this.query, {required this.wasSuccessful, required this.payload});

    /// Creates a QueryResult for a failed Query
    factory QueryResult.failed(Query query, {String errorMsg = ""}) => QueryResult._(query, wasSuccessful: false, payload: {'ERROR': errorMsg});

    /// Creates a QueryResult for a successful Query
    factory QueryResult.success(Query query, {JSON payload = const {}}) => QueryResult._(query, wasSuccessful: true, payload: payload);

    /// The name of the entity that the [Query] changed
    String get entityName => query.entityName;

    /// If the [Query] failed.
    bool get wasNotSuccessful => !wasSuccessful;
}