import 'package:flutter/material.dart';

/// Enum defining the types of questions available in the form
enum QuestionType {
  string,
  number,
  email,
  singleChoice,
  multipleChoice,
  date,
  time,
  dateTime,
  slider,
}

/// Base class for all form questions
abstract class FormQuestion {
  final String id;
  final String title;
  final String? text;
  final QuestionType questionType;
  final bool isOptional;

  const FormQuestion({
    required this.id,
    required this.title,
    this.text,
    required this.questionType,
    this.isOptional = false,
  });
}

/// Question for string/text input
class StringQuestion extends FormQuestion {
  final int? maxLength;
  final int? minLength;
  final String? placeholder;
  final bool multiline;

  const StringQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.maxLength,
    this.minLength,
    this.placeholder,
    this.multiline = false,
  }) : super(questionType: QuestionType.string);
}

/// Question for number input
class NumberQuestion extends FormQuestion {
  final double? min;
  final double? max;
  final String? placeholder;
  final bool allowDecimals;

  const NumberQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.min,
    this.max,
    this.placeholder,
    this.allowDecimals = false,
  }) : super(questionType: QuestionType.number);
}

/// Question for email input
class EmailQuestion extends FormQuestion {
  final String? placeholder;

  const EmailQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.placeholder,
  }) : super(questionType: QuestionType.email);
}

/// Question for single choice selection
class SingleChoiceQuestion extends FormQuestion {
  final List<String> options;
  final String? fieldKey;

  const SingleChoiceQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    required this.options,
    this.fieldKey,
  }) : super(questionType: QuestionType.singleChoice);
}

/// Question for multiple choice selection
class MultipleChoiceQuestion extends FormQuestion {
  final List<String> options;
  final int? maxSelections;
  final int? minSelections;

  const MultipleChoiceQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    required this.options,
    this.maxSelections,
    this.minSelections,
  }) : super(questionType: QuestionType.multipleChoice);
}

/// Question for date picker
class DateQuestion extends FormQuestion {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? placeholder;
  final bool allowBefore; // Allow dates before today
  final bool allowAfter;  // Allow dates after today

  const DateQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.placeholder,
    this.allowBefore = true,
    this.allowAfter = true,
  }) : super(questionType: QuestionType.date);
}

/// Question for time picker
class TimeQuestion extends FormQuestion {
  final TimeOfDay? initialTime;
  final String? placeholder;

  const TimeQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.initialTime,
    this.placeholder,
  }) : super(questionType: QuestionType.time);
}

/// Question for date and time picker
class DateTimeQuestion extends FormQuestion {
  final DateTime? initialDateTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? placeholder;
  final bool allowBefore; // Allow dates before today
  final bool allowAfter;  // Allow dates after today

  const DateTimeQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    this.initialDateTime,
    this.firstDate,
    this.lastDate,
    this.placeholder,
    this.allowBefore = true,
    this.allowAfter = true,
  }) : super(questionType: QuestionType.dateTime);
}

/// Question for slider input
class SliderQuestion extends FormQuestion {
  final double min;
  final double max;
  final double? initialValue;
  final int? divisions;
  final String? label;
  final bool showLabels;

  const SliderQuestion({
    required super.id,
    required super.title,
    super.text,
    super.isOptional,
    required this.min,
    required this.max,
    this.initialValue,
    this.divisions,
    this.label,
    this.showLabels = true,
  }) : super(questionType: QuestionType.slider);
}