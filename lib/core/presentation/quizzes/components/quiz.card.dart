import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizCard extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const QuizCard({super.key, required this.quiz});

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.quiz['title'],
              style: Get.textTheme.titleSmall,
            ),
            SizedBox(height: 8),
            Text(
              '${widget.quiz['questions']} questions • ${widget.quiz['difficulty']}',
              style: Get.textTheme.labelMedium,
            ),
            SizedBox(height: 8),
            Chip(
              label: Text(widget.quiz['category']),
              backgroundColor: Colors.blue[100],
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
