

class UserModel {
  final double balance;
  final String email;
  final String id;
  final String name;
  final String username;

  UserModel({
    required this.balance,
    required this.email,
    required this.id,
    required this.name,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      balance: (json['balance'] as num).toDouble(),
      email: json['email'],
      id: json['id'],
      name: json['name'],
      username: json['username'],
    );
  }
}
