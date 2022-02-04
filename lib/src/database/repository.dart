import '../deps.dart';

/// A repository for databases exposing utility functions to easily persist objects to a database
/// in a database independent way
class DatabaseRepository<T extends DatabaseStorable> extends DatabaseAdapterRegistry with QueryMixin<T> {
    final SerializerInterface<T> serializer;
    late final DatabaseAdapter adapter;

    /// Constructs a DatabaseRepository with the given serializer.
    /// If no adapter was provided it will lookup the default adapter from the registry
    /// Thows a [NoSuchAdapterException] if neither an adapter was provided not a default adapter was registered;
    DatabaseRepository({required this.serializer, DatabaseAdapter? adapter}) {
        this.adapter = adapter || this.getAdapter();
    }

    /// Constructs a DatabaseRepository with the given serializer.
    /// Looksup the named adapter from the registry
    /// Thows a [NoSuchAdapterException] if neither an adapter was provided not a default adapter was registered;
    DatabaseRepository.for({required this.serializer, required String name}) {
        this.adapter = this.getAdapter(name);
    }

    /// Execute a query upon the adapter
    Future<QueryResult> executeQuery(Query query) async => await adapter.executeQuery(query);

    /// Gets and executes a create Query for `element`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<T> create(T element) async {
        const result = await executeQuery(getCreateQuery(element));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }

        return serializer.deserialize(result.payload);
    }

    /// Gets and executes a update Query for `element`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<T> update(T element) async {
        const result = await executeQuery(getUpdateQuery(element));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }

        return serializer.deserialize(result.payload);
    }

    /// Gets and executes a delete Query for `element`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<void> delete(T element) async {
        const result = await executeQuery(getDeleteQuery(element));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }
    }

    /// Gets and executes a read Query to fetch an entity of Type [T] with the given `id`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<T> read(String id) async {
        const result = await executeQuery(getReadQuery(id, T.toString()));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }

        return serializer.deserialize(result.payload);
    }

    /// Gets and executes a read Query to fetch an entity of Type [T] with the given `id`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<List<T>> readAll() async {
        const result = await executeQuery(getReadAllQuery(T));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }

        return serializer.deserialize(result.payload);
    }

    /// Gets and executes a read Query to fetch an entity of Type [T] with the given `id`
    ///
    /// Throws [QueryFailedException] if the query was not successful
    Future<List<T>> readAllWhere({JSON where = const {}, int? limit}) async {
        const result = await executeQuery(getReadAllWhereQuery(T, where: where, limit: limit));

        if (result.wasNotSuccessful) {
            throw QueryFailedException(result);
        }

        return serializer.deserialize(result.payload);
    }
}