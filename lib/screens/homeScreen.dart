import 'package:Quizzy/screens/quizScreen.dart';
import 'package:Quizzy/utils/color.dart';
import 'package:Quizzy/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quizzy',
          style: GoogleFonts.caesarDressing(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: screenHeight * 0.06,
        forceMaterialTransparency: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/bg/bg home.jpg',
            width: screenWidth,
            height: screenHeight,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CustomPageRouteRight(page: QuizScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.15,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
