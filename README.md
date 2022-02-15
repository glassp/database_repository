# Database Repository for Dart/Flutter
[![codecov](https://codecov.io/gh/glassp/database_repository/branch/main/graph/badge.svg?token=OJLTL5V8WN)](https://codecov.io/gh/glassp/database_repository)

Use this Repository pattern to abstract the Database Logic away and use an abstract interface.

## How to install
```bash
dart pub add database_repository
```

## How to use
```dart
void main() {
    final myDatabaseAdapter = /* A DatabaseAdapter */
    final mySerializer = /* Some Serializer for your entities */
    
    // Register a Database Adapter that you want to use.
    DatabaseAdapterRegistry.register(myDatabaseAdapter);

    final repository = DatabaseRepository.fromRegistry(serializer: mySerializer);
    
    // Now use some methods such as create() etc.
}
```