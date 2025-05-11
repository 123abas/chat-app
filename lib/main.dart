import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pges/chat_page.dart';
import 'package:chat_app/pges/login_pages.dart';
import 'package:chat_app/pges/regiser_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}
class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigator-
      routes: {'LoginPages':(context)=>LoginPages(),
      'RegiserPage':(context)=>RegiserPage(),
     ChatPage.id:(context)=>ChatPage(),
     },
      debugShowCheckedModeBanner: false,
      initialRoute:'LoginPages' ,);
  }
}