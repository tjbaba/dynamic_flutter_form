import 'package:flutter/material.dart';
import '../models/form_config.dart';

/// Creates input decoration for form fields
InputDecoration createFormDecoration({
  String? hint,
  String? label,
  String? errorText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  VoidCallback? onSuffixIconTap,
  required FormConfig config,
}) {
  return InputDecoration(
    hintText: hint,
    labelText: label,
    errorText: errorText,
    hintStyle: TextStyle(
      color: config.hintColor,
      fontSize: 16,
    ),
    labelStyle: TextStyle(
      color: config.subtitleColor,
      fontSize: 16,
    ),
    errorStyle: const TextStyle(
      color: Colors.red,
      fontSize: 14,
    ),
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: config.primaryColor)
        : null,
    suffixIcon: suffixIcon != null
        ? IconButton(
      icon: Icon(suffixIcon, color: config.primaryColor),
      onPressed: onSuffixIconTap,
    )
        : null,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.borderRadius),
      borderSide: BorderSide(color: config.borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.borderRadius),
      borderSide: BorderSide(color: config.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.borderRadius),
      borderSide: BorderSide(color: config.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.borderRadius),
      borderSide: const BorderSide(color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(config.borderRadius),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    filled: true,
    fillColor: config.backgroundColor,
  );
}

/// Creates a styled container for choice options
Container createChoiceContainer({
  required Widget child,
  required bool isSelected,
  required FormConfig config,
  VoidCallback? onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(config.borderRadius),
      border: Border.all(
        color: isSelected ? config.primaryColor : config.borderColor,
        width: isSelected ? 2 : 1,
      ),
      color: isSelected
          ? config.primaryColor.withValues(alpha: 0.1)
          : config.backgroundColor,
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(config.borderRadius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    ),
  );
}

/// Creates a question header with title and subtitle
Widget createQuestionHeader({
  required String title,
  required String subtitle,
  required FormConfig config,
  bool isRequired = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      RichText(
        text: TextSpan(
          text: title,
          style: config.defaultTitleStyle,
          children: isRequired
              ? [
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red,
                fontSize: config.defaultTitleStyle.fontSize,
                fontWeight: config.defaultTitleStyle.fontWeight,
              ),
            ),
          ]
              : null,
        ),
      ),
      if (subtitle.isNotEmpty) ...[
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: config.defaultSubtitleStyle,
        ),
      ],
      const SizedBox(height: 24),
    ],
  );
}

/// Creates an option indicator (letter/number) for choice fields
Widget createOptionIndicator({
  required String text,
  required bool isSelected,
  required FormConfig config,
}) {
  return Container(
    height: 32,
    width: 32,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: isSelected ? config.primaryColorDark : Colors.transparent,
      border: Border.all(
        color: config.primaryColorDark,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isSelected ? Colors.white : config.primaryColorDark,
      ),
    ),
  );
}

/// Creates a loading indicator
Widget createLoadingIndicator({required FormConfig config}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(config.primaryColor),
    ),
  );
}

/// Creates an error message widget
Widget createErrorMessage({
  required String message,
  required FormConfig config,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(config.borderRadius),
      border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}