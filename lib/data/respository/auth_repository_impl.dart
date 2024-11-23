import 'package:user_notifier/data/firebase_services/services.dart';
import 'package:user_notifier/domain/models/user_model.dart';
import 'package:user_notifier/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> storeUserData(UserModel userModel) async {
    await firestore
        .collection("users")
        .doc(currentUser!.uid)
        .set(userModel.toMap());
  }
}
