import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isro_quiz_app/module/quiz/controller/quiz_controller.dart';
import 'package:isro_quiz_app/module/quiz/model/quiz_question.dart';
import 'package:isro_quiz_app/module/quiz/views/quiz_result_view.dart';

class McqView extends StatefulWidget {
  const McqView({super.key});

  @override
  State<McqView> createState() => _McqViewState();
}

class _McqViewState extends State<McqView> with AutomaticKeepAliveClientMixin {
  final QuizController controller = Get.put(QuizController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.filteredQuestions.isEmpty) {
          return _buildNoQuestionsView();
        }

        return Column(
          children: [
            _buildFilters(),
            const Divider(height: 1),
            _buildQuestionProgress(),
            const Divider(height: 1),
            Expanded(
              child: Obx(() {
                return PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentQuestionIndex.value = index;
                  },
                  itemCount: controller.filteredQuestions.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildQuestionCard(
                              controller.filteredQuestions[index]),
                          const SizedBox(height: 16),
                          _buildNavigationButtons(
                              controller.filteredQuestions[index]),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isLastQuestion && controller.selectedAnswer != null) {
          return FloatingActionButton.extended(
            onPressed: () async {
              if (controller.selectedAnswer != null) {
                final result = controller.calculateResults();
                await Get.to(() => QuizResultView(result: result));
                // Reset the quiz after viewing results
                controller.filterQuestions();
              } else {
                Get.snackbar(
                  'Answer Required',
                  'Please select an answer before submitting',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
              }
            },
            backgroundColor: Colors.blue.shade600,
            label: const Text('Submit Quiz'),
            icon: const Icon(Icons.assignment_turned_in),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filter Questions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown(
                    value: controller.selectedSubject.value,
                    items: controller.subjects,
                    onChanged: (value) {
                      controller.selectedSubject.value = value ?? 'All';
                      controller.filterQuestions();
                    },
                    label: 'Subject',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown(
                    value: controller.selectedDifficulty.value,
                    items: controller.difficulties,
                    onChanged: (value) {
                      controller.selectedDifficulty.value = value ?? 'All';
                      controller.filterQuestions();
                    },
                    label: 'Difficulty',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String label,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
                iconSize: 24,
                elevation: 8,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                dropdownColor: Colors.white,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionProgress() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LinearProgressIndicator(
        value: (controller.currentQuestionIndex.value + 1) /
            controller.filteredQuestions.length,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade400),
      ),
    );
  }

  Widget _buildQuestionCard(QuizQuestion question) {
    return Obx(() {
      final currentIndex = controller.currentQuestionIndex.value;
      final selectedAnswer = controller.selectedAnswers.isNotEmpty &&
              currentIndex < controller.selectedAnswers.length
          ? controller.selectedAnswers[currentIndex]
          : null;

      // Show explanation if an answer is selected
      final showExplanation =
          selectedAnswer != null && question.explanation != null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentIndex + 1} of ${controller.filteredQuestions.length}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.questionText,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...question.options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = selectedAnswer == index;
            final isCorrect = index == question.correctAnswerIndex;

            return GestureDetector(
              onTap: () => controller.selectAnswer(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? isCorrect
                          ? Colors.green.shade100
                          : Colors.red.shade100
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? isCorrect
                            ? Colors.green
                            : Colors.red
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? isCorrect
                                ? Colors.green
                                : Colors.red
                            : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? isCorrect
                                  ? Colors.green
                                  : Colors.red
                              : Colors.grey.shade400,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              isCorrect ? Icons.check : Icons.close,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected
                              ? isCorrect
                                  ? Colors.green.shade900
                                  : Colors.red.shade900
                              : Colors.black87,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          if (showExplanation) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explanation:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(question.explanation!),
                ],
              ),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildNavigationButtons(QuizQuestion question) {
    return Obx(() {
      final currentIndex = controller.currentQuestionIndex.value;
      final isLastQuestion =
          currentIndex == controller.filteredQuestions.length - 1;
      final isFirstQuestion = currentIndex == 0;
      final hasSelectedAnswer =
          controller.selectedAnswers.length > currentIndex &&
              controller.selectedAnswers[currentIndex] != null;

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirstQuestion)
            ElevatedButton.icon(
              onPressed: () {
                controller.previousQuestion();
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black87,
              ),
            )
          else
            const SizedBox(width: 100),
          if (!isLastQuestion)
            ElevatedButton.icon(
              onPressed: hasSelectedAnswer
                  ? () {
                      controller.nextQuestion();
                    }
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
            )
          else
            const SizedBox(width: 100),
        ],
      );
    });
  }

  Widget _buildNoQuestionsView() {
    return Column(
      children: [
        _buildFilters(),
        const Divider(height: 1),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.quiz_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No questions found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your filters',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.filterQuestions();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
