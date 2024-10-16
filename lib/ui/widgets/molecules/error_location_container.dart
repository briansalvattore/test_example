import 'package:flutter/material.dart';

class ErrorLocationContainer extends StatelessWidget {
  const ErrorLocationContainer({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_rounded,
            size: 100.0,
            color: Colors.amber,
          ),
          const SizedBox(height: 20.0),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
