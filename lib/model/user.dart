class User {
  final String id;
  final String username;
  final String fullName;
  final String password;
  User(
      {required this.username,
      required this.fullName,
      required this.password,
      required this.id});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      fullName: map['fullName'],
      password: map['password'],
    );
  }
}
