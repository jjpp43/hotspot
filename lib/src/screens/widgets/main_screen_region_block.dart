import 'dart:ui';

import 'package:flutter/material.dart';

class MainScreenRegionBlock extends StatelessWidget {
  final String img;
  final String title;
  const MainScreenRegionBlock({
    super.key,
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          img,
          width: 120,
          fit: BoxFit.fill,
        ),
        Container(
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontVariations: <FontVariation>[FontVariation('wght', 400)],
              letterSpacing: 1,
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
