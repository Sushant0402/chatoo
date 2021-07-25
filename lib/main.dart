import 'package:chatoo/screens/authScreen.dart';
import 'package:chatoo/screens/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff7368e4),
        canvasColor: Color(0xff242830).withOpacity(0.5),
        accentColor: Color(0xffADA7F3),
        accentColorBrightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Color(0xffADA7F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Color(0xff7368e4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      home: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen();
          }
          return AuthScreen();
        }
      )
    );
  }
}
