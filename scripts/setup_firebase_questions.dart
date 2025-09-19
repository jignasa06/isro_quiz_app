import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isro_quiz_app/module/quiz/data/sample_quiz_data.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: 'YOUR_APP_ID',
      messagingSenderId: 'YOUR_SENDER_ID',
      projectId: 'YOUR_PROJECT_ID',
      storageBucket: 'YOUR_STORAGE_BUCKET',
    ),
  );

  final firestore = FirebaseFirestore.instance;
  final questions = getSampleQuizQuestions();
  
  print('🚀 Starting to upload ${questions.length} questions to Firestore...');
  
  try {
    // Delete existing questions if any
    final batch = firestore.batch();
    final existingQuestions = await firestore.collection('quiz_questions').get();
    
    if (existingQuestions.docs.isNotEmpty) {
      print('🗑️ Found ${existingQuestions.docs.length} existing questions. Deleting...');
      for (final doc in existingQuestions.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
    
    // Add new questions
    for (var i = 0; i < questions.length; i++) {
      final question = questions[i];
      await firestore.collection('quiz_questions').add({
        'questionText': question.questionText,
        'options': question.options,
        'correctAnswerIndex': question.correctAnswerIndex,
        'subject': question.subject,
        'difficulty': question.difficulty,
        'explanation': question.explanation,
      });
      print('✅ Added question ${i + 1}/${questions.length}');
    }
    
    print('\n🎉 Successfully uploaded ${questions.length} questions to Firestore!');
  } catch (e) {
    print('❌ Error uploading questions: $e');
  } finally {
    exit(0);
  }
}
