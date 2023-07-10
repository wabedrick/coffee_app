class User {
  final int id;
  final String email;
  final String name;
  final String group;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.group,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      group: json['group'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'group': group,
      };
}
