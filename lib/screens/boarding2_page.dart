import 'package:flutter/material.dart';
import 'package:joblyst/constant/colors.dart';
import 'package:joblyst/screens/login_page.dart';

class Boarding2Page extends StatelessWidget {
  final String? message;

  const Boarding2Page({Key? key, this.message}) : super(key: key);

  Widget _elevatedButton(String text, BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: 20.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(120, 50),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/boarding2.png'),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: Text(
                    "Browse Job List",
                    style: TextStyle(
                      fontSize: 22,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: Text(
                    "We can find the best job for you",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.secondary1Color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 20.0,
              bottom: 20.0,
              child: Image.asset('images/slide2.png'),
            ),
            _elevatedButton("Start Journey", context),
            if (message != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 20.0, 8.0, 0.0),
                child: Text(
                  message!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
