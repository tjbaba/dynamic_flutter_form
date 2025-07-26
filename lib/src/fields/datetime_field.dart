import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Fixed DateTime field with allowBefore/allowAfter support
class DynamicDateTimeField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onDateTimeChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final DateTime? initialDateTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? placeholder;
  final String? errorMessage;
  final bool allowBefore; // Allow dates before today
  final bool allowAfter;  // Allow dates after today

  const DynamicDateTimeField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onDateTimeChanged,
    required this.onSubmit,
    this.theme,
    this.initialDateTime,
    this.firstDate,
    this.lastDate,
    this.placeholder,
    this.errorMessage,
    this.allowBefore = true,
    this.allowAfter = true,
  });

  @override
  State<DynamicDateTimeField> createState() => _DynamicDateTimeFieldState();
}

class _DynamicDateTimeFieldState extends State<DynamicDateTimeField> {
  DateTime? selectedDateTime;

  FormTheme get currentTheme => widget.theme ?? const FormTheme();

  @override
  void initState() {
    super.initState();
    _parseValue(widget.value);
  }

  @override
  void didUpdateWidget(DynamicDateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Always parse the new value, even if it seems the same
    _parseValue(widget.value);
  }

  void _parseValue(String value) {
    if (value.isNotEmpty) {
      try {
        selectedDateTime = DateTime.parse(value);
      } catch (e) {
        selectedDateTime = null;
      }
    } else {
      selectedDateTime = null;
    }
  }

  DateTime _calculateFirstDate() {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    if (widget.firstDate != null) {
      return widget.firstDate!;
    }

    if (!widget.allowBefore) {
      return todayStart; // Start from today if past dates not allowed
    }

    return DateTime(1900); // Default far back date
  }

  DateTime _calculateLastDate() {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    if (widget.lastDate != null) {
      return widget.lastDate!;
    }

    if (!widget.allowAfter) {
      return todayStart; // End at today if future dates not allowed
    }

    return DateTime(2100); // Default far future date
  }

  Future<void> _selectDateTime() async {
    // Step 1: Select Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: _calculateFirstDate(),
      lastDate: _calculateLastDate(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: currentTheme.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) return;

    // Step 2: Select Time
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: currentTheme.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    // Combine date and time
    final DateTime newDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      selectedDateTime = newDateTime;
    });

    // Save as ISO string
    widget.onDateTimeChanged(newDateTime.toIso8601String());
  }

  String get displayText {
    if (selectedDateTime != null) {
      final date = '${selectedDateTime!.day.toString().padLeft(2, '0')}/${selectedDateTime!.month.toString().padLeft(2, '0')}/${selectedDateTime!.year}';
      final time = TimeOfDay.fromDateTime(selectedDateTime!).format(context);
      return '$date at $time';
    }
    return widget.placeholder ?? 'Select date and time';
  }

  String get _helperText {
    List<String> restrictions = [];

    if (!widget.allowBefore && !widget.allowAfter) {
      restrictions.add('Only today');
    } else if (!widget.allowBefore) {
      restrictions.add('Future dates only');
    } else if (!widget.allowAfter) {
      restrictions.add('Past dates only');
    }

    return restrictions.isNotEmpty ? restrictions.join(', ') : '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: currentTheme.titleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.subTitle,
          style: TextStyle(
            color: currentTheme.subtitleColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: _selectDateTime,
          child: Container(
            width: double.infinity,
            height: 50.0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: currentTheme.primaryColor),
              borderRadius: BorderRadius.circular(currentTheme.borderRadius),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.event,
                  color: currentTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: selectedDateTime != null
                          ? currentTheme.titleColor
                          : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_helperText.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _helperText,
            style: TextStyle(
              color: currentTheme.subtitleColor,
              fontSize: 12,
            ),
          ),
        ],
        if (widget.errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorMessage!,
            style: TextStyle(
              color: currentTheme.errorColor,
              fontSize: 14,
            ),
          ),
        ],
      ],
    );
  }
}