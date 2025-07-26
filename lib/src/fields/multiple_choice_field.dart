import 'package:flutter/material.dart';
import '../components/flashing_widget.dart';
import '../utils/get_character_from_index.dart';
import '../models/form_theme.dart';

/// Multiple choice field widget - completely rewritten
class DynamicMultipleChoiceField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final List<String> options;
  final Function(String) onChoiceSelected;
  final FormTheme? theme;

  const DynamicMultipleChoiceField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.options,
    required this.onChoiceSelected,
    this.theme,
  });

  @override
  State<DynamicMultipleChoiceField> createState() => _DynamicMultipleChoiceFieldState();
}

class _DynamicMultipleChoiceFieldState extends State<DynamicMultipleChoiceField> {
  List<String> selectedItems = [];

  FormTheme get currentTheme => widget.theme ?? const FormTheme();

  @override
  void initState() {
    super.initState();
    if (widget.value.isNotEmpty) {
      selectedItems = widget.value.split(", ");
    }
  }

  void _toggleOption(String option) {
    setState(() {
      if (selectedItems.contains(option)) {
        selectedItems.remove(option);
      } else {
        selectedItems.add(option);
      }

      final result = selectedItems.join(", ");
      widget.onChoiceSelected(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
              final isSelected = selectedItems.contains(option);

              return FlashingWidget(
                beforeFlashing: () {
                  _toggleOption(option);
                },
                onTap: () {},
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
                      Row(
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
                          const SizedBox(width: 8),
                          Text(
                            option,
                            style: TextStyle(
                              color: currentTheme.titleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          color: currentTheme.primaryColorDark,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}