import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mysqpl_with_flutter/pages/chat_screen.dart';
import 'package:mysqpl_with_flutter/pages/login.dart';
import 'package:mysqpl_with_flutter/pages/register.dart';
import 'package:mysqpl_with_flutter/pages/welcom_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCkhKAx6vMe-z2w6Db_wXp-5t3jfQeHkh0",
            appId: "1:1037118513656:android:588a3ded65ae591a99360d",
            messagingSenderId: "1037118513656",
            projectId: "first-59545",
          ),
        )
      : await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}); // Corrected syntax for constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      initialRoute: '/', // Set initial route to '/'
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
