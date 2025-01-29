import 'package:flutter/material.dart';
import 'package:quizentialz/core/presentation/main/main.page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 35, bottom: 15),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFF182637),
            ),
            child: Text(
              "A Complete helping hand for your studies...",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              "CHILL QUIZZESNTIALZ IS THERE\nFOR YOU",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Color(0xFF98A7AF),
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                  ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              "WORK BUILD THE TRUST AUTOMATICALLY",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(80),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: Color(0xFFFC4C25),
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  SelectedDrawer.selectedIndex.value = 2;
                },
                child: Text(
                  "Play Now",
                ),
              ),
            ),
          ),
          Image.network(
            "https://static.wixstatic.com/media/511164_366e459460a74a9aaf7218088674da7c~mv2.png/v1/crop/x_0,y_0,w_1921,h_1080/fill/w_1395,h_772,fp_0.50_0.50,q_90,usm_0.66_1.00_0.01,enc_avif,quality_auto/Image%20(21).png",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
