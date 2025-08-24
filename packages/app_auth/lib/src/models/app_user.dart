import 'package:app_core/app_core.dart';

class AuthIdentity extends BaseObject {
  final String id;
  final String userName;
  final String email;
  final String? avatarUrl;
  final String? authToken;

  const AuthIdentity({required this.id, required this.userName, required this.email, this.avatarUrl, this.authToken});

  @override
  List<Object?> get props => [id, userName, email, avatarUrl, authToken];

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'displayName': userName, 'email': email, 'avatarUrl': avatarUrl, 'authToken': authToken};
  }

  factory AuthIdentity.fromJson(Map<String, dynamic> json) {
    return AuthIdentity(id: json['id'], userName: json['displayName'], email: json['email'], avatarUrl: json['avatarUrl'], authToken: json['authToken']);
  }
}
