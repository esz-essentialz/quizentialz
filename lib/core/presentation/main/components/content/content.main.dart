import 'package:flutter/material.dart';
import 'package:quizentialz/core/presentation/main/components/content/components/card1.main.dart';
import 'components/card2.main.dart';
import 'components/card3.main.dart';
import 'components/card4.main.dart';
import 'components/card5.main.dart';
import 'components/card6.main.dart';

class MainScreenContent extends StatefulWidget {
  const MainScreenContent({
    super.key,
  });

  @override
  State<MainScreenContent> createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreenContent> {
  final cards = [
    Card1(),
    Card2(),
    Card3(),
    Card4(),
    Card5(),
    Card6(),
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 90),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return cards[index];
        },
      ),
    );
  }
}
