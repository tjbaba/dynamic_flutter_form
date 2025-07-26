import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Date picker field widget with allowBefore/allowAfter support
class DynamicDateField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onDateChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? placeholder;
  final String? errorMessage;
  final bool allowBefore; // Allow dates before today
  final bool allowAfter;  // Allow dates after today

  const DynamicDateField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onDateChanged,
    required this.onSubmit,
    this.theme,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.placeholder,
    this.errorMessage,
    this.allowBefore = true,
    this.allowAfter = true,
  });

  @override
  State<DynamicDateField> createState() => _DynamicDateFieldState();
}

class _DynamicDateFieldState extends State<DynamicDateField> {
  late TextEditingController _controller;
  DateTime? selectedDate;
  final FormTheme _defaultTheme = const FormTheme();

  FormTheme get currentTheme => widget.theme ?? _defaultTheme;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    if (widget.value.isNotEmpty) {
      try {
        selectedDate = DateTime.parse(widget.value);
        _controller.text = _formatDate(selectedDate!);
      } catch (e) {
        selectedDate = null;
      }
    }
  }

  @override
  void didUpdateWidget(DynamicDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
      if (widget.value.isNotEmpty) {
        try {
          selectedDate = DateTime.parse(widget.value);
          _controller.text = _formatDate(selectedDate!);
        } catch (e) {
          selectedDate = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? widget.initialDate ?? DateTime.now(),
      firstDate: _calculateFirstDate(),
      lastDate: _calculateLastDate(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: currentTheme.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controller.text = _formatDate(picked);
      });
      widget.onDateChanged(picked.toIso8601String());
    }
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
          onTap: _selectDate,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50.0,
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
              right: 10,
              left: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: currentTheme.primaryColor),
              borderRadius: BorderRadius.circular(currentTheme.borderRadius),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: currentTheme.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? _formatDate(selectedDate!)
                        : widget.placeholder ?? 'Select a date',
                    style: TextStyle(
                      color: selectedDate != null
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