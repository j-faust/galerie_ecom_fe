
class SignupRequest {
  final String username;
  final String email;
  final Set<String> role;
  final String password;

  SignupRequest({
    required this.username,
    required this.email,
    required this.role,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role.toList(),
      'password': password,
    };
  }
}