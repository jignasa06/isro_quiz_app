class QuizQuestion {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String subject;
  final String difficulty; // 'easy', 'medium', 'hard'
  final String? explanation;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.subject,
    required this.difficulty,
    this.explanation,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> data, String id) {
    return QuizQuestion(
      id: id,
      questionText: data['questionText'] ?? '',
      options: List<String>.from(data['options'] ?? []),
      correctAnswerIndex: data['correctAnswerIndex'] ?? 0,
      subject: data['subject'] ?? 'General',
      difficulty: data['difficulty'] ?? 'medium',
      explanation: data['explanation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
      'subject': subject,
      'difficulty': difficulty,
      'explanation': explanation,
    };
  }
}

class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final DateTime timestamp;

  QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  double get scorePercentage => (correctAnswers / totalQuestions) * 100;

  factory QuizResult.fromMap(Map<String, dynamic> data) {
    return QuizResult(
      totalQuestions: data['totalQuestions'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      timestamp: data['timestamp']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'timestamp': timestamp,
    };
  }
}
