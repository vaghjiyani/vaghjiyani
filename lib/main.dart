import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wallpaper_app/login_page.dart';
import 'package:wallpaper_app/main_page.dart';
import 'package:wallpaper_app/preview_page.dart'; // Adjust to your path

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDwNTAEqTJYJiMkKDu_RmDjz3RkeUrNtM0",
          appId: "1:139640029038:android:26b0972213e348b74b4b7f",
          messagingSenderId: "139640029038",
          projectId: "wallpaper-389d3"));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(), // Launch your LoginPage
  ));
}
