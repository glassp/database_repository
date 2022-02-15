import '../deps.dart';

/// A repository for databases exposing utility functions to easily persist
/// objects to a database
/// in a database independent way
class DatabaseRepository<T extends DatabaseStorable>
    extends DatabaseAdapterRegistry with QueryMixin<T> {
  /// The serializer that the repository can use to convert between an object
  /// and JSON
  final SerializerInterface<T> serializer;

  /// The [DatabaseAdapter] that is used to persist the objects
  late final DatabaseAdapter adapter;

  /// Constructs a DatabaseRepository with the given serializer.
  /// If no adapter was provided it will lookup the default adapter from the
  /// registry
  /// Thows a [NoSuchAdapterException] if neither an adapter was provided not
  /// a default adapter was registered;
  DatabaseRepository({required this.serializer, DatabaseAdapter? adapter}) {
    this.adapter = adapter ?? DatabaseAdapterRegistry.getAdapter();
  }

  /// Constructs a DatabaseRepository with the given serializer.
  /// Looksup the named adapter from the registry
  /// Thows a [NoSuchAdapterException] if neither an adapter was provided not
  /// a default adapter was registered;
  DatabaseRepository.fromRegistry(
      {required this.serializer, required String name}) {
    adapter = DatabaseAdapterRegistry.getAdapter(name);
  }

  /// Execute a query upon the adapter
  @override
  Future<QueryResult> executeQuery(Query query) async =>
      await adapter.executeQuery(query);

  /// Gets and executes a create Query for `element`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<T> create(T element) async {
    final result = await executeQuery(getCreateQuery(element));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }

    return serializer.deserialize(result.payload);
  }

  /// Gets and executes a update Query for `element`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<T> update(T element) async {
    final result = await executeQuery(getUpdateQuery(element));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }

    return serializer.deserialize(result.payload);
  }

  /// Gets and executes a delete Query for `element`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<void> delete(T element) async {
    final result = await executeQuery(getDeleteQuery(element));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }
  }

  /// Gets and executes a read Query to fetch an entity of Type [T] with the
  /// given `id`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<T> read(String id) async {
    final result = await executeQuery(getReadQuery(id, type: T));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }

    return serializer.deserialize(result.payload);
  }

  /// Gets and executes a read Query to fetch an entity of Type [T] with the
  /// given `id`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<List<T>> readAll() async {
    final result = await executeQuery(getReadAllQuery(type: T));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }

    final elems = <T>[];
    for (final json in result.payload.values) {
      if (json is! JSON) {
        continue;
      }

      final elem = serializer.deserialize(json);
      elems.add(elem);
    }

    return elems;
  }

  /// Gets and executes a read Query to fetch an entity of Type [T] with the
  /// given `id`
  ///
  /// Throws [QueryFailedException] if the query was not successful
  Future<List<T>> readAllWhere(
      {List<Constraint> where = const [], int? limit}) async {
    final result = await executeQuery(
        getReadAllWhereQuery(type: T, where: where, limit: limit));

    if (result.wasNotSuccessful) {
      throw QueryFailedException(result);
    }

    final elems = <T>[];
    for (final json in result.payload.values) {
      if (json.runtimeType != JSON) {
        continue;
      }

      final elem = serializer.deserialize(json);
      elems.add(elem);
    }

    return elems;
  }
}
