import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final List<Map<String, dynamic>> leaders = [
    {'name': 'Alex Johnson', 'score': 1250, 'avatar': 'assets/images/avatar1.jpg'},
    {'name': 'Sam Lee', 'score': 1100, 'avatar': 'assets/images/avatar2.jpg'},
    {'name': 'Taylor Swift', 'score': 950, 'avatar': 'assets/images/avatar3.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Leaderboard',
              style: Get.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            ...leaders.map((leader) => LeaderTile(leader: leader)).toList(),
          ],
        ),
      ),
    );
  }
}

class LeaderTile extends StatelessWidget {
  final Map<String, dynamic> leader;

  const LeaderTile({super.key, required this.leader});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(leader['avatar']),
      ),
      title: Text(leader['name']),
      trailing: Text(
        '${leader['score']}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
