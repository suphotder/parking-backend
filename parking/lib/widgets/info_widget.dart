import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  String text;
  String data;

  InfoWidget({
    super.key,
    required this.text,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          data,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
