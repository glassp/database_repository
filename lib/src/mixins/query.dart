import '../deps.dart';

/// A mixin providing methods on creating Queries
mixin QueryMixin<T extends DatabaseStorable> {
  /// Executes the query and returns the result.
  /// The method should not throw but rather return a [QueryResult.failed]
  Future<QueryResult> executeQuery(Query query);

  /// generates a query that execute a create operation on the database
  Query getCreateQuery(T element) => Query(
        entityName: element.runtimeType.toString(),
        action: QueryAction.create,
        payload: element.toJson(),
      );

  /// generates a query that execute a update operation on the database
  Query getUpdateQuery(T element) => Query(
        entityName: element.runtimeType.toString(),
        action: QueryAction.update,
        payload: element.toJson(),
      );

  /// generates a query that execute a read operation on the database by
  /// applying a search function
  Query getReadAllWhereQuery({
    required Type type,
    List<Constraint> where = const [],
    int? limit,
  }) =>
      Query(
        entityName: type.toString(),
        action: QueryAction.read,
        where: where,
        limit: limit,
      );

  /// generates a query that execute a read operation on the database for an
  /// object with a given id.
  Query getReadQuery(String id, {required Type type}) => Query(
        entityName: type.toString(),
        action: QueryAction.read,
        payload: {"id": id},
        limit: 1,
      );

  /// generates a query that execute a read operation on the database fetching
  /// all objects
  Query getReadAllQuery({required Type type}) =>
      getReadAllWhereQuery(type: type);

  /// generates a query that execute a delete operation on the database
  Query getDeleteQuery(T element) => Query(
      entityName: element.runtimeType.toString(),
      action: QueryAction.delete,
      payload: element.toJson());

  /// generates a create or update query depending if the object should be
  /// updated if it exists
  Query getStoreQuery(T element, {bool updateIfExists = false}) {
    if (updateIfExists) {
      return getUpdateQuery(element);
    }

    return getCreateQuery(element);
  }
}
