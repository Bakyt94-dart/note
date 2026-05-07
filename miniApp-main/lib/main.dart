import 'package:flutter/material.dart';
import 'package:flutter_appp/database/app_database.dart';
import 'package:flutter_appp/home/home_page.dart';
import 'package:flutter_appp/home/onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


late final AppDatabase appDatabase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  appDatabase = AppDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 MyApp({super.key});
  bool isOnboardingShown = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page')
    );
  }
}