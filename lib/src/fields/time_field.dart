import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Fixed Time field - handles all edge cases
class DynamicTimeField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onTimeChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final TimeOfDay? initialTime;
  final String? placeholder;
  final String? errorMessage;

  const DynamicTimeField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onTimeChanged,
    required this.onSubmit,
    this.theme,
    this.initialTime,
    this.placeholder,
    this.errorMessage,
  });

  @override
  State<DynamicTimeField> createState() => _DynamicTimeFieldState();
}

class _DynamicTimeFieldState extends State<DynamicTimeField> {
  TimeOfDay? selectedTime;

  FormTheme get currentTheme => widget.theme ?? const FormTheme();

  @override
  void initState() {
    super.initState();
    _parseValue(widget.value);
  }

  @override
  void didUpdateWidget(DynamicTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Always parse the new value, even if it seems the same
    _parseValue(widget.value);
  }

  void _parseValue(String value) {
    if (value.isNotEmpty && value.contains(':')) {
      final parts = value.split(':');
      if (parts.length >= 2) {
        try {
          final hour = int.parse(parts[0]);
          final minute = int.parse(parts[1]);
          if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
            selectedTime = TimeOfDay(hour: hour, minute: minute);
          } else {
            selectedTime = null;
          }
        } catch (e) {
          selectedTime = null;
        }
      } else {
        selectedTime = null;
      }
    } else {
      selectedTime = null;
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
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

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });

      // Format as HH:mm
      final timeString = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      widget.onTimeChanged(timeString);
    }
  }

  String get displayText {
    if (selectedTime != null) {
      return selectedTime!.format(context);
    }
    return widget.placeholder ?? 'Select a time';
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
          onTap: _selectTime,
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
                  Icons.access_time,
                  color: currentTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    displayText,
                    style: TextStyle(
                      color: selectedTime != null
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