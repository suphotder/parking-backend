import 'package:flutter/material.dart';

void dialogAlert(BuildContext context, bool isError, String text) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        isError ? "Error" : "Success",
        style: TextStyle(
          fontSize: 16,
          color: isError ? Colors.red : Colors.green,
        ),
      ),
      content: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'OK',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ],
    ),
  );
}
