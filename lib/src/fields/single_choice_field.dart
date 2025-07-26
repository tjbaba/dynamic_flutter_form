import 'package:flutter/material.dart';
import '../components/flashing_widget.dart';
import '../utils/get_character_from_index.dart';
import '../models/form_theme.dart';

/// Single choice field widget matching your original design with theme support
class DynamicSingleChoiceField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final List<String> options;
  final Function(String) onNextTapped;
  final FormTheme? theme;

  const DynamicSingleChoiceField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.options,
    required this.onNextTapped,
    this.theme,
  });

  @override
  State<DynamicSingleChoiceField> createState() => _DynamicSingleChoiceFieldState();
}

class _DynamicSingleChoiceFieldState extends State<DynamicSingleChoiceField> {
  int? selectedIndex;
  String? selectedOption;
  final FormTheme _defaultTheme = const FormTheme();

  FormTheme get currentTheme => widget.theme ?? _defaultTheme;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.value.isNotEmpty ? widget.value : null;
    selectedIndex = selectedOption != null
        ? widget.options.indexWhere((option) => option == selectedOption)
        : null;
    if (selectedIndex == -1) selectedIndex = null;
  }

  @override
  void didUpdateWidget(DynamicSingleChoiceField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      selectedOption = widget.value.isNotEmpty ? widget.value : null;
      selectedIndex = selectedOption != null
          ? widget.options.indexWhere((option) => option == selectedOption)
          : null;
      if (selectedIndex == -1) selectedIndex = null;
    }
  }

  void _onOptionSelected(int index) {
    setState(() {
      selectedIndex = index;
      selectedOption = widget.options[index];
    });
  }

  void _onOptionTapped(int index) {
    widget.onNextTapped(widget.options[index]);
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
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: widget.options.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            final isSelected = selectedIndex == index;

            return FlashingWidget(
              beforeFlashing: () => _onOptionSelected(index),
              onTap: () => _onOptionTapped(index),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(currentTheme.borderRadius),
                  border: Border.all(color: currentTheme.primaryColor),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : currentTheme.primaryColorDark,
                              border: Border.all(color: currentTheme.primaryColorDark),
                              borderRadius: BorderRadius.circular(currentTheme.borderRadius),
                            ),
                            height: 25,
                            width: 25,
                            alignment: Alignment.center,
                            child: Text(
                              getCharacterFromIndex(index).toUpperCase(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? currentTheme.primaryColorDark
                                    : Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                color: currentTheme.titleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check,
                        color: currentTheme.primaryColorDark,
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}