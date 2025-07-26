/// Class representing the result/answer for a form question
class FormResult {
  /// Unique identifier for the form element
  final String elementId;

  /// The user's submission/answer
  final String submission;

  /// Type of the form element (for categorization)
  final String? type;

  /// Whether the field is valid
  final bool isValid;

  /// Validation error message if any
  final String? errorMessage;

  FormResult({
    required this.elementId,
    required this.submission,
    this.type,
    this.isValid = true,
    this.errorMessage,
  });

  /// Create a copy of this FormResult with updated values
  FormResult copyWith({
    String? elementId,
    String? submission,
    String? type,
    bool? isValid,
    String? errorMessage,
  }) {
    return FormResult(
      elementId: elementId ?? this.elementId,
      submission: submission ?? this.submission,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// Convert FormResult to JSON
  Map<String, dynamic> toJson() {
    return {
      'elementId': elementId,
      'submission': submission,
      'type': type,
      'isValid': isValid,
      'errorMessage': errorMessage,
    };
  }

  /// Create FormResult from JSON
  factory FormResult.fromJson(Map<String, dynamic> json) {
    return FormResult(
      elementId: json['elementId'] as String,
      submission: json['submission'] as String,
      type: json['type'] as String?,
      isValid: json['isValid'] as bool? ?? true,
      errorMessage: json['errorMessage'] as String?,
    );
  }

  @override
  String toString() {
    return 'FormResult{elementId: $elementId, submission: $submission, type: $type, isValid: $isValid}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FormResult &&
        other.elementId == elementId &&
        other.submission == submission &&
        other.type == type;
  }

  @override
  int get hashCode {
    return elementId.hashCode ^ submission.hashCode ^ (type?.hashCode ?? 0);
  }
}