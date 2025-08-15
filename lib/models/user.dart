
class User {
  final String userId; 
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePicture;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePicture

  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(), 
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName:  json['lastName'] ?? '',
      profilePicture: json['profilePicture']
      );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'profilePicture': profilePicture
  };
}