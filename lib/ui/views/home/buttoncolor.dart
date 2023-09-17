import 'package:flutter/material.dart';

Widget buildButtonWithBorder({
  required String text,
  required bool isSelected,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(20.0),
          color: isSelected ? Color.fromARGB(255, 138, 32, 236) : null),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
