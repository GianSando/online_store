import 'package:flutter/material.dart';

class AppColors {
  static const oscureColor = Color(0xFF10355B);
  static const greenOscure = Color(0xFF205A6D);
  static const fondoColors = Color(0xFF01545D);

  static const greenLight = Color(0xFF008186);
  static const greenAcents = Color(0xFF53E39C);
  static const greenAcents2 = Color(0xFF71FEBA);
  static const text = Color(0xFFFFFFFF);
  static const colorWhite2 = Color(0xFFF3F7E0);
  static const headerColor = Color(0xFFF2F6DF);
  static const greyColor = Color(0xFF829788);

  static const gradientColor1 = LinearGradient(
    colors: [
      greenAcents,
      greenAcents2,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const gradientColor2 = LinearGradient(
    colors: [
      greyColor,
      colorWhite2,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    //stops: [0.5, 0.5],
  );
}
