import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:p8/pages/LoginPage.dart';
import 'package:p8/pages/add_name_page.dart';
import 'package:p8/pages/edit_name_page.dart';
import 'package:p8/pages/home_page.dart';
import 'firebase_options.dart';

void main() async{

   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => const Home(),
        '/add': (context) => const AddNamePage(),
        '/edit': (context) => const EditNamePage(),
      },
    );
  }
}


