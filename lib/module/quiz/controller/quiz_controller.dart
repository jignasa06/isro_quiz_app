import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:isro_quiz_app/constants/text_constants.dart';
import '../data/sample_quiz_data.dart';
import '../model/quiz_question.dart';

class QuizController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final PageController pageController;

  final RxList<QuizQuestion> questions = <QuizQuestion>[].obs;
  final RxList<QuizQuestion> filteredQuestions = <QuizQuestion>[].obs;
  var currentQuestionIndex = 0.obs;
  final RxList<int?> selectedAnswers = <int?>[].obs;
  final RxSet<int> _submittedQuestions = <int>{}.obs;
  final RxBool isLoading = false.obs;
  final RxString selectedSubject = TextConstants.all.obs;
  final RxString selectedDifficulty = TextConstants.all.obs;

  final RxList<String> subjects = <String>[].obs;
  final List<String> difficulties = [
    TextConstants.all,
    TextConstants.easy,
    TextConstants.medium,
    TextConstants.hard,
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    fetchQuestions();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> fetchQuestions() async {
    try {
      isLoading.value = true;

      try {
        final querySnapshot = await _firestore
            .collection(TextConstants.quizQuestionsCollection)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          questions.value = querySnapshot.docs
              .map((doc) => QuizQuestion.fromMap(doc.data(), doc.id))
              .toList();
        } else {
          questions.value = getSampleQuizQuestions();
        }
      } catch (e) {
        questions.value = getSampleQuizQuestions();
      }

      final uniqueSubjects = questions.map((q) => q.subject).toSet().toList();
      subjects.value = [TextConstants.all, ...uniqueSubjects];

      filterQuestions();
    } catch (e) {
      Get.snackbar(TextConstants.error, TextConstants.quizLoadingError);
      questions.value = getSampleQuizQuestions();
      filterQuestions();
    } finally {
      isLoading.value = false;
    }
  }

  void filterQuestions() {
    final currentSubject = selectedSubject.value;
    final currentDifficulty = selectedDifficulty.value;

    filteredQuestions.value = questions.where((question) {
      final subjectMatch = currentSubject == TextConstants.all ||
          question.subject == currentSubject;
      final difficultyMatch = currentDifficulty == TextConstants.all ||
          question.difficulty.toLowerCase() == currentDifficulty.toLowerCase();
      return subjectMatch && difficultyMatch;
    }).toList();

    resetQuiz();
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswers.clear();
    if (filteredQuestions.isNotEmpty) {
      selectedAnswers.addAll(List.filled(filteredQuestions.length, null));
    }
  }

  void selectAnswer(int answerIndex) {
    if (currentQuestionIndex.value < selectedAnswers.length) {
      final newAnswers = List<int?>.from(selectedAnswers);
      newAnswers[currentQuestionIndex.value] = answerIndex;
      selectedAnswers.assignAll(newAnswers);
      update();
    }
  }

  bool isSubmitted(int questionIndex) {
    try {
      return _submittedQuestions.contains(questionIndex);
    } catch (e) {
      return false;
    }
  }

  void submitAnswer(int questionIndex) {
    try {
      if (questionIndex >= 0 &&
          questionIndex < selectedAnswers.length &&
          selectedAnswers[questionIndex] != null) {
        _submittedQuestions.add(questionIndex);
        update();
      }
    } catch (e) {
      rethrow;
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < filteredQuestions.length - 1) {
      currentQuestionIndex.value++;
      pageController.animateToPage(
        currentQuestionIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
      pageController.animateToPage(
        currentQuestionIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      update();
    }
  }

  Map<String, dynamic> calculateResults() {
    final Map<String, dynamic> results = {
      TextConstants.totalQuestions: filteredQuestions.length,
      TextConstants.correctAnswers: 0,
      TextConstants.incorrectAnswers: 0,
      TextConstants.skippedQuestions: 0,
      TextConstants.score: 0,
      TextConstants.subjectWise: {},
      TextConstants.difficultyWise: {},
    };

    final Map<String, int> subjectTotals = {};
    final Map<String, int> subjectCorrect = {};
    final Map<String, int> difficultyTotals = {};
    final Map<String, int> difficultyCorrect = {};

    for (final subject in subjects.where((s) => s != TextConstants.all)) {
      subjectTotals[subject] = 0;
      subjectCorrect[subject] = 0;
    }

    for (final difficulty
        in difficulties.where((d) => d != TextConstants.all)) {
      difficultyTotals[difficulty] = 0;
      difficultyCorrect[difficulty] = 0;
    }

    for (int i = 0; i < filteredQuestions.length; i++) {
      final question = filteredQuestions[i];
      final isCorrect = selectedAnswers[i] == question.correctAnswerIndex;

      if (isCorrect) {
        results[TextConstants.correctAnswers]++;
        results[TextConstants.score]++;

        subjectCorrect[question.subject] =
            (subjectCorrect[question.subject] ?? 0) + 1;
        difficultyCorrect[question.difficulty] =
            (difficultyCorrect[question.difficulty] ?? 0) + 1;
      } else if (selectedAnswers[i] != null) {
        results[TextConstants.incorrectAnswers]++;
      } else {
        results[TextConstants.skippedQuestions]++;
      }

      subjectTotals[question.subject] =
          (subjectTotals[question.subject] ?? 0) + 1;
      difficultyTotals[question.difficulty] =
          (difficultyTotals[question.difficulty] ?? 0) + 1;
    }

    results[TextConstants.subjectWise] = {
      for (final subject in subjectTotals.keys)
        subject: {
          TextConstants.total: subjectTotals[subject],
          TextConstants.correct: subjectCorrect[subject] ?? 0,
          TextConstants.percentage: subjectTotals[subject]! > 0
              ? ((subjectCorrect[subject] ?? 0) / subjectTotals[subject]! * 100)
                  .round()
              : 0,
        },
    };

    results[TextConstants.difficultyWise] = {
      for (final difficulty in difficultyTotals.keys)
        difficulty: {
          TextConstants.total: difficultyTotals[difficulty],
          TextConstants.correct: difficultyCorrect[difficulty] ?? 0,
          TextConstants.percentage: difficultyTotals[difficulty]! > 0
              ? ((difficultyCorrect[difficulty] ?? 0) /
                      difficultyTotals[difficulty]! *
                      100)
                  .round()
              : 0,
        },
    };

    results[TextConstants.score] =
        (results[TextConstants.score] / filteredQuestions.length * 100).round();

    return results;
  }

  bool isOptionSelected(int questionIndex, int optionIndex) {
    return selectedAnswers[questionIndex] == optionIndex;
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < filteredQuestions.length; i++) {
      if (selectedAnswers[i] == filteredQuestions[i].correctAnswerIndex) {
        score++;
      }
    }
    return score;
  }
}
