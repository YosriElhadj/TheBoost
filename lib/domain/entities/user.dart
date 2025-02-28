class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final DateTime createdAt;
  
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    required this.createdAt,
  });
}