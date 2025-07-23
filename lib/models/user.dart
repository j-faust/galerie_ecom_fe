
class User {
  final String userId; 
  final String username;
  final String email;

  User({
    required this.userId,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(), 
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'email': email,
  };
}