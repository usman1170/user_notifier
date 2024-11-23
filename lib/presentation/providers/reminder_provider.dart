import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:user_notifier/domain/models/user_model.dart';
import 'package:user_notifier/domain/repository/reminder_repository.dart';

class ReminderProvider with ChangeNotifier {
  final ReminderRepository reminderRepository;

  ReminderProvider({required this.reminderRepository});

  bool _isLoading = false;
  UserModel? _userData;
  String _selectedDate = "";

  bool get isLoading => _isLoading;
  UserModel? get userData => _userData;
  String get selectedDate => _selectedDate;

  Future<void> getData() async {
    try {
      _setLoading(true);
      final data = await reminderRepository.getData();
      log(data.toString());
      _userData = data;
      notifyListeners();
    } catch (e) {
      debugPrint("Error: $e");
      throw Exception("Something went wrong");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateUserDate(String date) async {
    try {
      if (_userData != null) {
        await reminderRepository.updateDate(_userData!.id, date);
        _userData = _userData!.copyWith(date: date);
        notifyListeners();
      } else {
        throw Exception("User data not available");
      }
    } catch (e) {
      debugPrint("Error updating date: $e");
      throw Exception("Failed to update date");
    }
  }

  void updateSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
