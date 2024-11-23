import 'package:user_notifier/data/firebase_services/services.dart';
import 'package:user_notifier/domain/models/user_model.dart';
import 'package:user_notifier/domain/repository/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  @override
  Future<UserModel> getData() async {
    final data =
        await firestore.collection("users").doc(currentUser!.uid).get();
    return UserModel.fromMap(data.data()!);
  }

  @override
  Future<void> updateDate(String userId, String date) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'date': date,
      });
    } catch (e) {
      throw Exception("Failed to update date: $e");
    }
  }
}
