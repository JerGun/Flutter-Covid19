import 'package:flutter/material.dart';

class ChartInfo extends StatelessWidget {
  const ChartInfo({
    required this.title,
    required this.color,
    required this.snapshot,
    Key? key,
  }) : super(key: key);

  final String title;
  final Color color;
  final snapshot;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey[700]),
            ),
            Text(snapshot),
          ],
        ),
      ],
    );
  }
}
