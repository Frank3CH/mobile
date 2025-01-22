
class User {
  final int id;
  final String username;
  final String email;
  final String type;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'type': type,
    };
  }
}
