import 'package:database_repository/database_repository.dart';
import 'package:test/test.dart';

import '../../__fake__/null_database_adapter.dart';
import '../../__fake__/user.dart';

void main() {
  final user = User();
  final failingAdapter = NullDatabaseAdapter(name: 'failing', shouldFail: true);
  final passingAdapter = NullDatabaseAdapter();

  DatabaseAdapterRegistry.register(passingAdapter);
  DatabaseAdapterRegistry.register(failingAdapter);

  final failingRepository = DatabaseRepository.fromRegistry(
    name: 'failing',
    serializer: Serializer<User>(User.fromJson),
  );

  final repository = DatabaseRepository(
    serializer: Serializer<User>(User.fromJson),
    adapter: passingAdapter,
  );

  test('create', () async {
    expect((await repository.create(user)).id, equals('DB-0'));
  });
  test('update', () async {
    expect((await repository.update(user)).id, equals('DB-0'));
  });
  test('delete', () async {
    await expectLater(repository.delete(user), completes);
  });
  test('read', () async {
    expect((await repository.read('DB-0')).id, equals('DB-0'));
  });
  test('readAll', () async {
    expect((await repository.readAll()).length, equals(4));
  });
  test('throws on failed Exception', () async {
    await expectLater(
      failingRepository.create(user),
      throwsA(isA<QueryFailedException>()),
    );
    await expectLater(
      failingRepository.update(user),
      throwsA(isA<QueryFailedException>()),
    );
    await expectLater(
      failingRepository.delete(user),
      throwsA(isA<QueryFailedException>()),
    );
    await expectLater(
      failingRepository.read(user.id),
      throwsA(isA<QueryFailedException>()),
    );
    await expectLater(
      failingRepository.readAll(),
      throwsA(isA<QueryFailedException>()),
    );
  });
}
