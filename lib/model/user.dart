class User {
  final String gender;
  final String email;
  final String phone;
  final String cell;
  final String nat;
  final String firstName;
  final String lastName;
  final String thumbnail;

  User({
    required this.gender,
    required this.email,
    required this.phone,
    required this.cell,
    required this.nat,
    required this.firstName,
    required this.lastName,
    required this.thumbnail,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? {};
    final picture = json['picture'] ?? {};

    return User(
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cell: json['cell'] ?? '',
      nat: json['nat'] ?? '',
      firstName: name['first'] ?? '',
      lastName: name['last'] ?? '',
      thumbnail: picture['thumbnail'] ?? 'https://via.placeholder.com/150',
    );
  }
}
