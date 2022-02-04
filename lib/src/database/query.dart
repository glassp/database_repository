import '../deps.dart';

/// An object containing all information about an Object that should be transfered to the Database.
class Query {
    /// The serialized object that should be transfered
    final JSON payload;

    /// A JSON object containing information on how to apply filter
    final JSON where;

    /// The name of the class that should be transfered
    final String entityName;

    /// On how many objects the Query should be applied
    final int? limit;

    /// The action that is to be executed
    final QueryAction action;

    /// Create a Query that can be executed by a [DatabaseAdapter]
    Query({
        required this.entityName, 
        required this.action, 
        this.where = const {}, 
        this.limit = null, 
        this.payload = const {},
    });

    @override
    String toString() => "<Query on $entityName of type ${action.name}>";
}

enum QueryAction {
    /// only store if element is new
    create,
    /// read from database
    read,
    /// store element or overwrite it
    update,
    /// delete element
    delete,
}