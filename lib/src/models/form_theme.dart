import 'package:flutter/material.dart';

/// Theme configuration for the dynamic form
class FormTheme {
  /// Primary color for the form elements
  final Color primaryColor;

  /// Dark variant of primary color
  final Color primaryColorDark;

  /// Background color for the form
  final Color backgroundColor;

  /// Text color for titles
  final Color titleColor;

  /// Text color for subtitles
  final Color subtitleColor;

  /// Text color for error messages
  final Color errorColor;

  /// Border radius for buttons and fields
  final double borderRadius;

  /// Animation duration for transitions
  final Duration animationDuration;

  const FormTheme({
    this.primaryColor = const Color(0xFF6200EE),
    this.primaryColorDark = const Color(0xFF3700B3),
    this.backgroundColor = Colors.white,
    this.titleColor = const Color(0xFF212121),
    this.subtitleColor = const Color(0xFF757575),
    this.errorColor = Colors.red,
    this.borderRadius = 5.0,
    this.animationDuration = const Duration(milliseconds: 400),
  });

  /// Create a copy of this FormTheme with updated values
  FormTheme copyWith({
    Color? primaryColor,
    Color? primaryColorDark,
    Color? backgroundColor,
    Color? titleColor,
    Color? subtitleColor,
    Color? errorColor,
    double? borderRadius,
    Duration? animationDuration,
  }) {
    return FormTheme(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColorDark: primaryColorDark ?? this.primaryColorDark,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      errorColor: errorColor ?? this.errorColor,
      borderRadius: borderRadius ?? this.borderRadius,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  /// Create a theme from a primary color
  factory FormTheme.fromColor(Color color) {
    return FormTheme(
      primaryColor: color,
      primaryColorDark: Color.lerp(color, Colors.black, 0.2) ?? color,
    );
  }

  /// Predefined themes
  static const FormTheme blue = FormTheme(
    primaryColor: Colors.blue,
    primaryColorDark: Color(0xFF1976D2),
  );

  static const FormTheme purple = FormTheme(
    primaryColor: Colors.purple,
    primaryColorDark: Color(0xFF7B1FA2),
  );

  static const FormTheme green = FormTheme(
    primaryColor: Colors.green,
    primaryColorDark: Color(0xFF388E3C),
  );

  static const FormTheme orange = FormTheme(
    primaryColor: Colors.orange,
    primaryColorDark: Color(0xFFF57C00),
  );

  static const FormTheme pink = FormTheme(
    primaryColor: Colors.pink,
    primaryColorDark: Color(0xFFC2185B),
  );

  static const FormTheme teal = FormTheme(
    primaryColor: Colors.teal,
    primaryColorDark: Color(0xFF00796B),
  );

  static const FormTheme indigo = FormTheme(
    primaryColor: Colors.indigo,
    primaryColorDark: Color(0xFF303F9F),
  );

  static const FormTheme red = FormTheme(
    primaryColor: Colors.red,
    primaryColorDark: Color(0xFFD32F2F),
  );
}