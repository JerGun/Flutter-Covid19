import 'package:flutter/material.dart';

class SymptomsItem extends StatelessWidget {
  const SymptomsItem({
    required this.icon,
    this.title = '',
    Key? key,
  }) : super(key: key);

  final String icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Image.asset(
              'assets/images/$icon.png',
            ),
          ),
        ),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
