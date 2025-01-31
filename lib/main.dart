import 'package:Quizzy/screens/splashScreen.dart';
import 'package:Quizzy/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/env/.env");
  runApp(ProviderScope(child: QuizApp()));
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
          surface: AppColors.surfaceColor,
          error: AppColors.errorColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.primaryTextColor,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.surfaceColor,
        buttonTheme: ButtonThemeData(
          buttonColor: AppColors.buttonColor,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.primaryTextColor),
          bodyMedium: TextStyle(color: AppColors.secondaryTextColor),
          headlineMedium: TextStyle(
              color: AppColors.primaryTextColor, fontWeight: FontWeight.bold),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor,
            foregroundColor: AppColors.buttonTextColor,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
