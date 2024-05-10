import 'package:flutter/material.dart';

class StreakBar extends StatelessWidget {
  final int streak;
  final int maxStars;
  final double starSize;

  StreakBar({required this.streak, this.maxStars = 5, this.starSize = 24});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    
    // Determine the number of filled stars based on the streak and maximum stars
    int filledStars = streak > maxStars ? maxStars : streak;

    // Add filled stars with padding
    for (int i = 0; i < filledStars; i++) {
      stars.add(
        Padding(
          padding: EdgeInsets.only(right: starSize * 0.4), // Padding is half the width of the star
          child: Image.asset(
            'images/colortrophy.png', // Path to your colorful trophy image
            width: starSize,
            height: starSize,
          ),
        ),
      );
    }

    // Add grey stars for remaining space with padding
    for (int i = filledStars; i < maxStars; i++) {
      stars.add(
        Padding(
          padding: EdgeInsets.only(right: starSize * 0.4), // Padding is half the width of the star
          child: Image.asset(
            'images/dulltrophy.png', // Path to your dull trophy image
            width: starSize,
            height: starSize,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }
}
