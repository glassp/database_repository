# Main Concept
## How should it be used
The User should register at least one `DatabaseAdapter` in the main() which will store it in a static context so that any further interaction with the `DatabaseRepository` could automatically use this `DatabaseAdapter`. The Adapter should also have the ability to be named so that one could use some factory-style constructor like `DatabaseRepository<MyEntityClass>.for('firebase')`, given that a `DatabaseAdapter` named `firebase` was registered. Also it should be noted that the first `DatabaseAdapter` that was registered will become the default so that any call like `DatabaseRepository<MyEntityClass>()` will automatically use the default `DatabaseAdapter`

## How should it work
There should be one global class `DatabaseRepository<T extends DatabaseStorable>` which will take some Entity `T` which (for convenience) must implement some basic methods like `toJson`, `get id` and so on.

This `DatabaseRepository` would then expose some basic methods like `store(T, {bool updateIfExists = false})`, `create(T)`, `update(T)`, `delete(T)`, `get(id)`, `getAll` which will create a `Query` object.
This `Query` object will act as an configuration (or state) for the `DatabaseAdapter`, which will use the `Query` to actually execute the operation on the database.

Given a Query which was created by the following code `DatabaseRepository<User>().store(newUser)`, the `DatabaseAdapter` would have to either execute a `create` or `update` operation based upon the fact if the underlying Database needs to differanciate between those two methods and upon the existance of the entity.

For example if we had a DatabaseImplemenation that just drops json files into some directories, then we wouldn’t have to differanciate between `create` and `update`. For sake of integrity we should in fact check if the flag `updateIfExists` is true. 
If the flag was false and the entity exists the underlying `DatabaseAdapter` should throw a `ForbiddenEntityOverwriteException`.

Also an easy way of checking if an Object exists already is to check if the object (`newUser` in our case) has an id. Any call to `newUser.id` should result in `null` as the User was not persisted yet. After passing it to `store` a new `User` object would be returned which would have an id (lets say its the id `12345`).
Any call to `store(user12345)` should throw an exception while any call to `store(user12345, updateIfExists: true)` should work just fine and overwrite the data.

## Performance and indexability
While we could just write any entity to the database and use some searching method to find the given entity again it would result in horrible performance.
The `DatabaseAdapter` should try to make the data as indexable as feasible. For example fetching an entity by id should have an ideal complexity of O(1) and a worst complexity of O(n).

Any other operation upon the database should aim for complexities around O(n)
