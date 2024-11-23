import 'package:user_notifier/domain/models/user_model.dart';

abstract class ReminderRepository {
  Future<UserModel> getData();
  Future<void> updateDate(String userId, String date);
}
