
class UserInfoResponse {
  final int id;
  final String username;
  final String? jwtToken;
  final List<String> roles;

  UserInfoResponse({
    required this.id,
    required this.username,
    required this.roles,
    this.jwtToken,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      id: json['id'],
      username: json['username'],
      jwtToken: json['jwtToken'],
      roles: List<String>.from(json['roles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'jwtToken': jwtToken,
      'roles': roles,
    };
  }
}