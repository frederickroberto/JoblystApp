import 'package:flutter/material.dart';
import 'package:joblyst/constant/colors.dart';

class BoardingPage extends StatelessWidget {
  const BoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/boarding1.png'),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 125.0),
                  child: Text(
                    "Hello, Let's Find Your Job With Us!",
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
                    "We help you find your job based on your talent and skill.",
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
              child: Image.asset('images/slide.png'),
            ),
            Positioned(
              right: 20.0,
              bottom: 20.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/boarding');
                },
                child: Image.asset('images/icon_next.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
