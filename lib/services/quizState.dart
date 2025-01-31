import 'package:Quizzy/services/quizModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizState {
  final int currentQuestionIndex;
  final int score;
  final Quiz? quiz;
  final int? selectedOptionIndex;
  final bool isAnswered;
  final bool isCorrect;

  QuizState({
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.quiz,
    this.selectedOptionIndex,
    this.isAnswered = false,
    this.isCorrect = false,
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    int? score,
    Quiz? quiz,
    int? selectedOptionIndex,
    bool? isAnswered,
    bool? isCorrect,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      quiz: quiz ?? this.quiz,
      selectedOptionIndex: selectedOptionIndex ?? this.selectedOptionIndex,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}

class QuizStateNotifier extends StateNotifier<QuizState> {
  QuizStateNotifier() : super(QuizState());

  void loadQuiz(Quiz quiz) {
    state = state.copyWith(quiz: quiz);
  }

  void selectOption(int index) {
    if (!state.isAnswered) {
      state = state.copyWith(selectedOptionIndex: index);
    }
  }

  void answerQuestion(int selectedIndex) {
    if (!state.isAnswered) {
      final currentQuestion = state.quiz?.questions[state.currentQuestionIndex];
      if (currentQuestion != null) {
        bool isCorrect = currentQuestion.options[selectedIndex].isCorrect;

        state = state.copyWith(
          selectedOptionIndex: selectedIndex,
          isAnswered: true,
          isCorrect: isCorrect,
          score: isCorrect ? state.score + 1 : state.score,
        );
      }
    }
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < state.quiz!.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        isAnswered: false,
        selectedOptionIndex: null,
        isCorrect: false,
      );
    }
  }

  void resetQuiz() {
    state = QuizState(
      quiz: state.quiz,
      score: 0,
      currentQuestionIndex: 0,
      isAnswered: false,
      selectedOptionIndex: null,
      isCorrect: false,
    );
  }
}

final quizStateProvider =
    StateNotifierProvider<QuizStateNotifier, QuizState>((ref) {
  return QuizStateNotifier();
});
