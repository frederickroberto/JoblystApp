import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:joblyst/screens/boarding_page.dart';
import 'package:joblyst/screens/boarding2_page.dart';
import 'package:joblyst/screens/register_page.dart';
import 'package:joblyst/screens/login_page.dart';
import 'package:joblyst/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/boarding': (context) => Boarding2Page(),
      },
    );
  }
}
