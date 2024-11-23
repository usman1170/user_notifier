import 'package:firebase_auth/firebase_auth.dart';

String mapFirebaseAuthErrorToMessage(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'This email is already in use. Please use a different email.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled.';
    case 'weak-password':
      return 'The password is too weak. Please use a stronger password.';
    case 'user-disabled':
      return 'This user account has been disabled.';
    case 'user-not-found':
      return 'No user found for this email.';
    case 'invalid-credential':
      return 'Invalid credentials. Please try again.';
    case 'wrong-password':
      return 'The password is incorrect. Please try again.';
    case 'network-request-failed':
      return 'Network error occurred. Please check your internet connection.';
    default:
      return 'An unknown error occurred. Please try again later.';
  }
}
