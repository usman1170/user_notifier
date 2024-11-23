import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> errorDialog(
      BuildContext context, String title, String massage) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(title),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 20,
              bottom: 12,
            ),
            child: Text(
              massage,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          )
        ],
      ),
    );
  }
}
