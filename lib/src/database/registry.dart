import '../deps.dart';

/// Class for managing DatabaseAdapters
abstract class DatabaseAdapterRegistry {
    static Map<String, DatabaseAdapter> _registeredAdapters = {};

    /// Registers a new adapter.
    /// The first adapter will be automatically set as default.
    /// The default adapter can be overwriten by setting `useAsDefault` to true.
    ///
    /// Thorws a [AdapterAlreadyRegisteredException] if a adapter with the given name already exists.
    /// Throws a [AdapterNameViolationException] if the adapter name is the empty string.
    static void register(DatabaseAdapter adapter, {bool useAsDefault = false}) {
        if (_registeredAdapters.contains(adapter.name)) {
            throw AdapterAlreadyRegisteredException();
        }

        if (adapter.name == "") {
            throw AdapterNameViolationException();
        }

        _registeredAdapters.putIfAbsent(adapter.name, () => adapter);
        // The first adapter to be registered will be the default adapter and will use the name "";
        _registeredAdapters.putIfAbsent("", () => adapter);

        if (useAsDefault) {
            _registeredAdapters.update("", (_) => adapter);
        }
    }

    /// Grabs a adapter from the registry.
    ///
    /// Thows a [NoSuchAdapterException] if a adapter with the given name does not exist.
    static getAdapter([String name = ""]) {
        if (_registeredAdapters.contains(name)) {
            throw NoSuchAdapterException();
        }

        return _registeredAdapters[name];
    }
}