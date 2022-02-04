import '../deps.dart';

/// Base class for Database Implementations
abstract class DatabaseAdapter with QueryMixin {
    /// The name of the adapter.
    /// Must be unique when registering this DatabaseAdapter
    final String name;
}