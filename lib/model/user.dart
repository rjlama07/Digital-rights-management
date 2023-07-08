class User {
  String firstName;
  String lastName;
  String email;
  String imageUrl;

  User(
      {required this.imageUrl,
      required this.firstName,
      required this.email,
      required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        imageUrl: json["imageUrl"],
        firstName: json["firstName"],
        email: json["email"],
        lastName: json["lastName"]);
  }
}
