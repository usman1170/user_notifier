import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_notifier/config/routes/routes.dart';
import 'package:user_notifier/config/utils.dart';
import 'package:user_notifier/data/firebase_services/firebase_notification_services.dart';
import 'package:user_notifier/presentation/auth/login.dart';
import 'package:user_notifier/presentation/providers/auth_provider.dart';
import 'package:user_notifier/presentation/providers/reminder_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseNotificationServices notificationServices =
      FirebaseNotificationServices();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notificationServices.requestNotificationPermissions();
      final reminderProvider =
          Provider.of<ReminderProvider>(context, listen: false);
      reminderProvider.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final reminderProvider = Provider.of<ReminderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authProvider.logout();
              Routes().pushReplacement(context, const LoginScreen());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: reminderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (reminderProvider.userData != null &&
                        reminderProvider.userData!.date.isNotEmpty)
                      Text(
                        "You set the reminder on: ${calculateDays(reminderProvider.userData!.date)}",
                      )
                    else
                      const Text("No user data available"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final pickedDate = await pickDate(context);
                        if (pickedDate.isNotEmpty) {
                          reminderProvider.updateSelectedDate(pickedDate);
                          await reminderProvider.updateUserDate(pickedDate);
                        } else {
                          Get.snackbar("Error", "Please select a valid date");
                        }
                      },
                      child: const Text("Pick Date"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
