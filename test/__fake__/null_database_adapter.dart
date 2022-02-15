import 'package:database_repository/database_repository.dart';

class NullDatabaseAdapter extends DatabaseAdapter {
  @override
  final String name;
  final bool shouldFail;

  NullDatabaseAdapter({this.name = "Null", this.shouldFail = false});

  @override
  Future<QueryResult> executeQuery(Query query) async {
    if (shouldFail) {
      return QueryResult.failed(query);
    }

    switch (query.action) {
      case QueryAction.create:
      case QueryAction.update:
        return QueryResult.success(
          query,
          payload: {"id": "DB-0"},
        );
      case QueryAction.delete:
        return QueryResult.success(
          query,
          payload: {"id": "DB-0"},
        );
      case QueryAction.read:
        if (query.limit == 1) {
          return QueryResult.success(
            query,
            payload: {"id": "DB-0"},
          );
        } else {
          return QueryResult.success(
            query,
            payload: {
              "DB-0": {"id": "DB-0"},
              "DB-1": {"id": "DB-1"},
              "DB-2": {"id": "DB-2"},
              "DB-3": {"id": "DB-3"},
            },
          );
        }
    }
  }
}
