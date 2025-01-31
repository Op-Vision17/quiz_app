import 'package:Quizzy/services/apiService.dart';
import 'package:Quizzy/services/quizModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final quizProvider = FutureProvider<Quiz>((ref) async {
  final apiService = ApiService();
  return await apiService.fetchQuizData();
});
