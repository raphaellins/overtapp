import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String email;
  String password;
  String _authToken;

  User(this.email, this.password);

  setToken(String token) {
    _authToken = token;
  }

  getToken() {
    return _authToken;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
