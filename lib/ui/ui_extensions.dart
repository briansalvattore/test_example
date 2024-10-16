import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
