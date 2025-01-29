import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/achievement.card.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Quick Learner',
      'description': 'Complete 5 quizzes in a day',
      'progress': 80,
      'icon': '🚀',
    },
    {
      'title': 'Knowledge Seeker',
      'description': 'Watch 50 educational videos',
      'progress': 60,
      'icon': '🧠',
    },
    // Add more achievements...
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
              'Your Achievements',
              style: Get.textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: achievements
                  .map(
                    (achievement) => AchievementCard(achievement: achievement),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
