import 'package:flutter/material.dart';

class MainScreenBlock extends StatelessWidget {
  final String img;
  final String title;
  const MainScreenBlock({
    super.key,
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.asset(
          img,
          width: 120,
          fit: BoxFit.fill,
        ),
        Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black,
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
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
