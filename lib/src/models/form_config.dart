import 'package:flutter/material.dart';

/// Configuration class for customizing the form appearance and behavior
class FormConfig {
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

  /// Text color for form fields
  final Color fieldTextColor;

  /// Color for form field borders
  final Color borderColor;

  /// Color for form field hints
  final Color hintColor;

  /// Text style for form titles
  final TextStyle? titleStyle;

  /// Text style for form subtitles
  final TextStyle? subtitleStyle;

  /// Text style for form fields
  final TextStyle? fieldTextStyle;

  /// Border radius for buttons and fields
  final double borderRadius;

  /// Padding for form pages
  final EdgeInsets pagePadding;

  /// Animation duration for page transitions
  final Duration animationDuration;

  /// Animation curve for page transitions
  final Curve animationCurve;

  /// Enable or disable the flashing effect
  final bool enableFlashingEffect;

  /// Duration of the flashing animation
  final Duration flashingDuration;

  /// Show progress bar at the top
  final bool showProgressBar;

  /// Height of the progress bar
  final double progressBarHeight;

  /// Button text for next action
  final String nextButtonText;

  /// Button text for back action
  final String backButtonText;

  /// Button text for finish action
  final String finishButtonText;

  const FormConfig({
    this.primaryColor = const Color(0xFF6200EE),
    this.primaryColorDark = const Color(0xFF3700B3),
    this.backgroundColor = Colors.white,
    this.titleColor = const Color(0xFF212121),
    this.subtitleColor = const Color(0xFF757575),
    this.fieldTextColor = const Color(0xFF424242),
    this.borderColor = const Color(0xFFE0E0E0),
    this.hintColor = const Color(0xFF9E9E9E),
    this.titleStyle,
    this.subtitleStyle,
    this.fieldTextStyle,
    this.borderRadius = 8.0,
    this.pagePadding = const EdgeInsets.all(24.0),
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.enableFlashingEffect = true,
    this.flashingDuration = const Duration(milliseconds: 100),
    this.showProgressBar = true,
    this.progressBarHeight = 8.0,
    this.nextButtonText = 'Next',
    this.backButtonText = 'Back',
    this.finishButtonText = 'Finish',
  });

  /// Create a copy of this FormConfig with updated values
  FormConfig copyWith({
    Color? primaryColor,
    Color? primaryColorDark,
    Color? backgroundColor,
    Color? titleColor,
    Color? subtitleColor,
    Color? fieldTextColor,
    Color? borderColor,
    Color? hintColor,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? fieldTextStyle,
    double? borderRadius,
    EdgeInsets? pagePadding,
    Duration? animationDuration,
    Curve? animationCurve,
    bool? enableFlashingEffect,
    Duration? flashingDuration,
    bool? showProgressBar,
    double? progressBarHeight,
    String? nextButtonText,
    String? backButtonText,
    String? finishButtonText,
  }) {
    return FormConfig(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColorDark: primaryColorDark ?? this.primaryColorDark,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      fieldTextColor: fieldTextColor ?? this.fieldTextColor,
      borderColor: borderColor ?? this.borderColor,
      hintColor: hintColor ?? this.hintColor,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      fieldTextStyle: fieldTextStyle ?? this.fieldTextStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      pagePadding: pagePadding ?? this.pagePadding,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      enableFlashingEffect: enableFlashingEffect ?? this.enableFlashingEffect,
      flashingDuration: flashingDuration ?? this.flashingDuration,
      showProgressBar: showProgressBar ?? this.showProgressBar,
      progressBarHeight: progressBarHeight ?? this.progressBarHeight,
      nextButtonText: nextButtonText ?? this.nextButtonText,
      backButtonText: backButtonText ?? this.backButtonText,
      finishButtonText: finishButtonText ?? this.finishButtonText,
    );
  }

  /// Default title text style
  TextStyle get defaultTitleStyle => titleStyle ?? TextStyle(
    color: titleColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  /// Default subtitle text style
  TextStyle get defaultSubtitleStyle => subtitleStyle ?? TextStyle(
    color: subtitleColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  /// Default field text style
  TextStyle get defaultFieldTextStyle => fieldTextStyle ?? TextStyle(
    color: fieldTextColor,
    fontSize: 16,
  );
}