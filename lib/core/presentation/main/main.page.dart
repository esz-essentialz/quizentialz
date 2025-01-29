import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizentialz/core/presentation/achievement/achivement.page.dart';
import 'package:quizentialz/core/theme/theme.dart';
import 'package:quizentialz/other/responsive.dart';

import '../dashboard/dashboard.page.dart';
import '../playlist/playlist.page.dart';
import '../profile/profile.page.dart';
import '../quizzes/quizzes.page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class DrawerItem {
  int id;
  String title;
  String icon;
  DrawerItem({
    required this.id,
    required this.title,
    required this.icon,
  });

  DrawerItem copyWith({
    int? id,
    String? title,
    String? icon,
  }) {
    return DrawerItem(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory DrawerItem.fromMap(Map<String, dynamic> map) {
    return DrawerItem(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DrawerItem.fromJson(String source) => DrawerItem.fromMap(json.decode(source));

  @override
  String toString() => 'DrawerItem(id: $id, title: $title, icon: $icon)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DrawerItem && other.id == id && other.title == title && other.icon == icon;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ icon.hashCode;
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  static final drawerList = <DrawerItem>[
    DrawerItem(id: 0, title: "Dashboard", icon: "assets/icons/home.png"),
    DrawerItem(id: 1, title: "Playlist", icon: "assets/icons/playlist.png"),
    DrawerItem(id: 2, title: "Quizzes", icon: "assets/icons/quiz.png"),
    DrawerItem(id: 3, title: "Achievements", icon: "assets/icons/Achievements.png"),
    DrawerItem(id: 4, title: "Profile", icon: "assets/icons/user.png"),
  ];

  static final List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    PlaylistsPage(),
    QuizzesPage(),
    AchievementsPage(),
    ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> state = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: state,
      backgroundColor: Themes.backgroundColor,
      drawer: Responsive.isDesktop(context)
          ? Drawer(
              child: Column(
                children: [],
              ),
            )
          : null,
      body: Stack(
        children: [
          Positioned(
            left: -180,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * .15,
              backgroundColor: Themes.nionClr.withAlpha(60),
            ),
          ),
          Positioned(
            right: 120,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * .15,
              backgroundColor: Themes.nionClr.withAlpha(30),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SizedBox(),
          ),
          Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 90,
                        height: 90,
                      ),
                      Text(
                        "Quzzentialz".toUpperCase(),
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      ...drawerList.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              textStyle: Get.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedIndex = e.id;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  e.title.toUpperCase(),
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: selectedIndex == e.id ? Colors.white : Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                AnimatedSize(
                                  duration: Duration(milliseconds: 400),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 5),
                                    width: selectedIndex == e.id ? 40 : 0,
                                    height: 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: Themes.btnColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (!Responsive.isDesktop(context))
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu_rounded,
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: _widgetOptions,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
