import 'package:flutter/material.dart';

class CustomText extends Text {
  const CustomText._(
    super.text, {
    super.style,
  });

  factory CustomText.title(String text) {
    return CustomText._(
      text,
      style: const TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  factory CustomText.big(String text) {
    return CustomText._(
      text,
      style: const TextStyle(
        fontSize: 200.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  factory CustomText.small(String text) {
    return CustomText._(
      text,
      style: const TextStyle(
        fontSize: 50.0,
      ),
    );
  }
}
