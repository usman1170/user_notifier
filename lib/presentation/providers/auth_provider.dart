import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_notifier/data/firebase_services/firebase_exceptions.dart';
import 'package:user_notifier/domain/models/user_model.dart';
import 'package:user_notifier/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      _setLoading(true);
      await authRepository.signUp(email, password);
      final userModel = UserModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: email,
        date: "",
      );
      await authRepository.storeUserData(userModel);
      _showSnackbar("Success", "Account created successfully!");
    } catch (e) {
      if (e is FirebaseAuthException) {
        _showSnackbar("Error", mapFirebaseAuthErrorToMessage(e));
      } else {
        _showSnackbar("Error", "Something went wrong");
      }
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> login(String email, String password) async {
    try {
      _setLoading(true);
      await authRepository.login(email, password);
      _showSnackbar("Success", "Logged in successfully!");
    } catch (e) {
      if (e is FirebaseAuthException) {
        _showSnackbar("Error", mapFirebaseAuthErrorToMessage(e));
      } else {
        _showSnackbar("Error", "Something went wrong");
      }
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);
      await authRepository.logout();
    } catch (e) {
      _showSnackbar("Error", "Something went wrong");
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message);
  }
}
