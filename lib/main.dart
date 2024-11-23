import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_notifier/data/firebase_services/services.dart';
import 'package:user_notifier/data/respository/auth_repository_impl.dart';
import 'package:user_notifier/data/respository/reminder_repository_impl.dart';
import 'package:user_notifier/firebase_options.dart';
import 'package:user_notifier/presentation/auth/login.dart';
import 'package:user_notifier/presentation/providers/auth_provider.dart';
import 'package:user_notifier/presentation/home/home.dart';
import 'package:user_notifier/presentation/providers/reminder_provider.dart';
import 'package:user_notifier/presentation/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider(authRepository: AuthRepositoryImpl())),
        ChangeNotifierProvider(
            create: (_) =>
                ReminderProvider(reminderRepository: ReminderRepositoryImpl())),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class SessionManager extends StatelessWidget {
  const SessionManager({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (currentUser != null) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
