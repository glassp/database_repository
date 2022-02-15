// ignore_for_file: avoid_classes_with_only_static_members

import 'package:meta/meta.dart';

import '../deps.dart';

/// Class for managing DatabaseAdapters
abstract class DatabaseAdapterRegistry {
  static final Map<String, DatabaseAdapter> _registeredAdapters = {};

  /// Registers a new adapter.
  /// The first adapter will be automatically set as default.
  /// The default adapter can be overwriten by setting `useAsDefault` to true.
  ///
  /// Throws a [AdapterAlreadyRegisteredException] if a adapter with the given
  /// name already exists.
  /// Throws a [AdapterNameViolationException] if the adapter name is the
  /// empty string.
  static void register(DatabaseAdapter adapter, {bool useAsDefault = false}) {
    if (_registeredAdapters.containsKey(adapter.name)) {
      throw AdapterAlreadyRegisteredException();
    }

    if (adapter.name == "") {
      throw AdapterNameViolationException();
    }

    _registeredAdapters.putIfAbsent(adapter.name, () => adapter);
    // The first adapter to be registered will be the default adapter and
    //will use the name "";
    _registeredAdapters.putIfAbsent("", () => adapter);

    if (useAsDefault) {
      _registeredAdapters.update("", (_) => adapter);
    }
  }

  /// Grabs a adapter from the registry.
  ///
  /// Thows a [NoSuchAdapterException] if a adapter with the given name
  /// does not exist.
  static DatabaseAdapter getAdapter([String name = ""]) {
    if (!_registeredAdapters.containsKey(name)) {
      throw NoSuchAdapterException();
    }

    return _registeredAdapters[name]!;
  }

  /// Returns a list of all registered keys and their Adapters class name
  @visibleForTesting
  static Map<String, Type> get registeredAdapters => _registeredAdapters.map(
        (key, value) => MapEntry(key, value.runtimeType),
      );
}
