import '../models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserModel(
      uid: 'user_1',
      name: email.split('@').first,
      email: email,
      role: email.contains('admin') ? UserRole.admin : UserRole.buyer,
      joinedAt: DateTime.now(),
    );
    return _currentUser!;
  }

  Future<UserModel> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    String phone = '',
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _currentUser = UserModel(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      role: UserRole.buyer,
      joinedAt: DateTime.now(),
    );
    return _currentUser!;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }
}
