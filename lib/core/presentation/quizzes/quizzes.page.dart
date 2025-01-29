import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/quiz.card.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final List<Map<String, dynamic>> quizzes = [
    {
      'title': 'JavaScript Basics',
      'questions': 20,
      'difficulty': 'Beginner',
      'category': 'Programming',
    },
    {
      'title': 'Python Data Structures',
      'questions': 15,
      'difficulty': 'Intermediate',
      'category': 'Programming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Available Quizzes',
              style: Get.textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: quizzes.map((quiz) => QuizCard(quiz: quiz)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
