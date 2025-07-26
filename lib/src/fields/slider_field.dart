import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Slider field widget
class DynamicSliderField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onSliderChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final double min;
  final double max;
  final double? initialValue;
  final int? divisions;
  final String? label;
  final bool showLabels;
  final String? errorMessage;

  const DynamicSliderField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onSliderChanged,
    required this.onSubmit,
    this.theme,
    required this.min,
    required this.max,
    this.initialValue,
    this.divisions,
    this.label,
    this.showLabels = true,
    this.errorMessage,
  });

  @override
  State<DynamicSliderField> createState() => _DynamicSliderFieldState();
}

class _DynamicSliderFieldState extends State<DynamicSliderField> {
  late double currentValue;
  final FormTheme _defaultTheme = const FormTheme();

  FormTheme get currentTheme => widget.theme ?? _defaultTheme;

  @override
  void initState() {
    super.initState();
    if (widget.value.isNotEmpty) {
      try {
        currentValue = double.parse(widget.value);
      } catch (e) {
        currentValue = widget.initialValue ?? widget.min;
      }
    } else {
      currentValue = widget.initialValue ?? widget.min;
    }
  }

  @override
  void didUpdateWidget(DynamicSliderField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && widget.value.isNotEmpty) {
      try {
        currentValue = double.parse(widget.value);
      } catch (e) {
        currentValue = widget.initialValue ?? widget.min;
      }
    }
  }

  String _getDisplayValue() {
    if (widget.divisions != null) {
      return currentValue.toInt().toString();
    }
    return currentValue.toStringAsFixed(1);
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

        // Current value display
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: currentTheme.primaryColor),
            borderRadius: BorderRadius.circular(currentTheme.borderRadius),
            color: currentTheme.primaryColor.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label ?? 'Value:',
                style: TextStyle(
                  color: currentTheme.titleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                _getDisplayValue(),
                style: TextStyle(
                  color: currentTheme.primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: currentTheme.primaryColor,
            inactiveTrackColor: currentTheme.primaryColor.withOpacity(0.3),
            thumbColor: currentTheme.primaryColorDark,
            overlayColor: currentTheme.primaryColor.withOpacity(0.2),
            valueIndicatorColor: currentTheme.primaryColorDark,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Slider(
            value: currentValue,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: _getDisplayValue(),
            onChanged: (value) {
              setState(() {
                currentValue = value;
              });
              widget.onSliderChanged(value.toString());
            },
          ),
        ),

        // Min/Max labels
        if (widget.showLabels) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.min.toString(),
                  style: TextStyle(
                    color: currentTheme.subtitleColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  widget.max.toString(),
                  style: TextStyle(
                    color: currentTheme.subtitleColor,
                    fontSize: 12,
                  ),
                ),
              ],
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