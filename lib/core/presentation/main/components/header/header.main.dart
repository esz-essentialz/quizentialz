import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quizentialz/core/theme/theme.dart';

class MainScreenHeader extends StatelessWidget {
  const MainScreenHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Themes.backgroundLightColor, width: 1.2),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(10),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 3,
                ),
                child: SizedBox(),
              ),
            ),
          ),
          HeaderContent(),
        ],
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  const HeaderContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 50,
          ),
          Spacer(),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                fillColor: Themes.backgroundLightColor,
                filled: true,
              ),
            ),
          ),
          Spacer(),
          Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 50,
          ),
        ],
      ),
    );
  }
}
