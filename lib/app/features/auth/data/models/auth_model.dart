import 'package:tracka/app/core/database/controller/database_controller.dart';
import 'package:tracka/app/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  String? userId;
  AuthModel({required super.username, required super.password}) {
    DatabaseController database = DatabaseController();
    database.getCurrentUserIdByUsername(username).then((value) {
      userId = value;
    });
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(username: json['username'] as String, password: json['password'] as String);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'userId': userId, 'username': username, 'password': password};
  }



  AuthEntity toEntity() {
    return AuthEntity(username: username, password: password);
  }
}
