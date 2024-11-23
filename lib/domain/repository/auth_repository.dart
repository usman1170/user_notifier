import 'package:user_notifier/domain/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signUp(String email, String password);
  Future<void> login(String email, String password);
  Future<void> logout();

  Future<void> storeUserData(UserModel userModel);
}
