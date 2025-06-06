

class User {
  int id;
  String name;
  String email;
  String mobileNumber;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      mobileNumber: json['mobileNumber'] as String,
    );
  }
}
