import 'package:Quizzy/screens/quizScreen.dart';
import 'package:Quizzy/services/quizState.dart';
import 'package:Quizzy/utils/color.dart';
import 'package:Quizzy/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen(
      {super.key, required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final quizStateNotifier = ref.read(quizStateProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results"),
        forceMaterialTransparency: true,
        toolbarHeight: screenHeight * 0.05,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg/bg quiz.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),
                  _buildPieChart(screenWidth),
                  SizedBox(height: screenHeight * 0.03),
                  ElevatedButton(
                    onPressed: () {
                      quizStateNotifier.resetQuiz();
                      Navigator.of(context).pushReplacement(
                        CustomPageRouteRight(
                          page: QuizScreen(),
                        ),
                      );
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
                      "Restart Quiz",
                      style: TextStyle(fontSize: screenWidth * 0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(double screenWidth) {
    Map<String, double> dataMap = {
      'Correct': score.toDouble(),
      'Incorrect': (totalQuestions - score).toDouble(),
    };

    List<Color> colorList = [
      Colors.green,
      Colors.red,
    ];

    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 1700),
      chartLegendSpacing: 32,
      chartRadius: screenWidth * 0.6,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 25,
      centerText: "$score/$totalQuestions",
      centerTextStyle: TextStyle(
        fontSize: screenWidth * 0.08,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      legendOptions: LegendOptions(
        showLegends: true,
        legendPosition: LegendPosition.bottom,
        legendTextStyle: TextStyle(
          fontSize: screenWidth * 0.04,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: true,
        chartValueStyle: TextStyle(
          fontSize: screenWidth * 0.05,
          color: const Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
