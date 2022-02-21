```dart
void main() {
    final myDatabaseAdapter = /* Initialize some DatabaseAdapter here */
    
    // Register a Database Adapter that you want to use.
    DatabaseAdapterRegistry.register(myDatabaseAdapter);

    final repository = DatabaseRepository.fromRegistry(serializer: mySerializer, name: 'hive');
    
    // Now use some methods such as create() etc.
}
```