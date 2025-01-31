import 'package:Quizzy/screens/resultScreen.dart';
import 'package:Quizzy/services/quizProvider.dart';
import 'package:Quizzy/services/quizState.dart';
import 'package:Quizzy/utils/color.dart';
import 'package:Quizzy/utils/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends ConsumerStatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int? selectedOptionIndex;

  @override
  Widget build(BuildContext context) {
    final quizAsync = ref.watch(quizProvider);
    final quizState = ref.watch(quizStateProvider);
    final quizStateNotifier = ref.read(quizStateProvider.notifier);

    ref.listen(quizProvider, (previous, next) {
      next.whenData((quiz) {
        if (quizState.quiz == null) {
          quizStateNotifier.loadQuiz(quiz);
        }
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quizzy',
          style: GoogleFonts.caesarDressing(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Text(
              "Score: ${quizState.score}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg/bg quiz.jpg',
              fit: BoxFit.cover,
            ),
          ),
          quizAsync.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text("Error: $error")),
            data: (quiz) {
              if (quizState.quiz == null) {
                return Center(child: CircularProgressIndicator());
              }

              final currentQuestion =
                  quizState.quiz!.questions[quizState.currentQuestionIndex];
              bool isAnswered = quizState.isAnswered;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Question ${quizState.currentQuestionIndex + 1}/${quizState.quiz!.questions.length}",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      currentQuestion.description,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    ...currentQuestion.options.asMap().entries.map((entry) {
                      int index = entry.key;
                      var option = entry.value;
                      bool isCorrect = option.isCorrect;

                      return GestureDetector(
                        onTap: () {
                          if (!isAnswered) {
                            setState(() {
                              selectedOptionIndex = index;
                            });
                          }
                        },
                        child: Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          color: isAnswered
                              ? (isCorrect
                                  ? AppColors.successColor
                                  : (index == quizState.selectedOptionIndex
                                      ? AppColors.errorColor
                                      : AppColors.backgroundColor))
                              : (index == selectedOptionIndex
                                  ? AppColors.secondaryColor
                                  : AppColors.backgroundColor),
                          child: ListTile(
                            title: Text(
                              "${String.fromCharCode(65 + index)}. ${option.description}",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryTextColor,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: selectedOptionIndex == null || isAnswered
                          ? null
                          : () {
                              quizStateNotifier
                                  .answerQuestion(selectedOptionIndex!);
                              setState(() {});
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonColor,
                        foregroundColor: AppColors.buttonTextColor,
                      ),
                      child: Text("Submit"),
                    ),
                    if (isAnswered)
                      ElevatedButton(
                        onPressed: () {
                          if (quizState.currentQuestionIndex ==
                              quizState.quiz!.questions.length - 1) {
                            Navigator.of(context).pushReplacement(
                              CustomPageRouteRight(
                                page: ResultScreen(
                                  score: quizState.score,
                                  totalQuestions:
                                      quizState.quiz!.questions.length,
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              selectedOptionIndex = null;
                            });
                            quizStateNotifier.nextQuestion();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          foregroundColor: AppColors.buttonTextColor,
                        ),
                        child: Text(
                          quizState.currentQuestionIndex ==
                                  quizState.quiz!.questions.length - 1
                              ? "Finish"
                              : "Next Question",
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
