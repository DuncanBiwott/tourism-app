import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourism/constants/constants.dart';
import 'package:tourism/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      textTheme: GoogleFonts.robotoCondensedTextTheme(),
       primaryColor: primary,
        // Use your color constant as the default button color
        buttonTheme: ButtonThemeData(
          buttonColor: primary2,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
        ),
        
      ),
      home:const  Splash()
    );
  }
}

