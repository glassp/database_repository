import 'package:database_repository/database_repository.dart';

class User extends DatabaseStorable {
  @override
  String id;

  @override
  bool isManaged;

  User({this.id = "0", this.isManaged = false});
  factory User.fromJson(JSON json) => User(id: json['id'] ?? "0");

  @override
  JSON toJson() => {
        "id": id,
      };
}
