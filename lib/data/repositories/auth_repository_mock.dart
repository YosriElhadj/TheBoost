// data/repositories/auth_repository_mock.dart

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryMock implements AuthRepository {
  User? _currentUser;
  
  // Mock users (in a real app, this would be a database)
  final List<UserModel> _users = [
    UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      phoneNumber: '+1234567890',
      createdAt: DateTime(2023, 1, 15),
    ),
    UserModel(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      phoneNumber: '+0987654321',
      createdAt: DateTime(2023, 2, 20),
    ),
  ];

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
    return _currentUser;
  }

  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    
    // For demo purposes, we're accepting any password
    try {
      final user = _users.firstWhere((user) => user.email == email);
      _currentUser = user;
      return user;
    } catch (e) {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<User> register(String name, String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    
    // Check if user already exists
    if (_users.any((user) => user.email == email)) {
      throw Exception('User with this email already exists');
    }
    
    // Create new user
    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
    );
    
    _users.add(newUser);
    _currentUser = newUser;
    
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(Duration(milliseconds: 300)); // Simulate network delay
    _currentUser = null;
  }

  @override
  Future<void> resetPassword(String email) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    
    // Check if user exists
    if (!_users.any((user) => user.email == email)) {
      throw Exception('User with this email does not exist');
    }
    
    // In a real app, this would send a password reset email
    return;
  }
}