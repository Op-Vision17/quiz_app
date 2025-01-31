class Quiz {
  final int id;
  final String title;
  final String topic;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.topic,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      questions: (json['questions'] as List)
          .map((question) => QuizQuestion.fromJson(question))
          .toList(),
    );
  }
}

class QuizQuestion {
  final int id;
  final String description;
  final List<QuizOption> options;

  QuizQuestion({
    required this.id,
    required this.description,
    required this.options,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      description: json['description'],
      options: (json['options'] as List)
          .map((option) => QuizOption.fromJson(option))
          .toList(),
    );
  }
}

class QuizOption {
  final int id;
  final String description;
  final bool isCorrect;

  QuizOption({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'],
      description: json['description'],
      isCorrect: json['is_correct'],
    );
  }
}
