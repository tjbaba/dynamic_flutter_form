import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Number field widget matching your original design with theme support
class DynamicNumberField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onTextChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final String? errorMessage;

  const DynamicNumberField({
    super.key,
    required this.title,
    required this.subTitle,
    required this.value,
    required this.onTextChanged,
    required this.onSubmit,
    this.theme,
    this.errorMessage,
  });

  @override
  State<DynamicNumberField> createState() => _DynamicNumberFieldState();
}

class _DynamicNumberFieldState extends State<DynamicNumberField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final FormTheme _defaultTheme = const FormTheme();

  FormTheme get currentTheme => widget.theme ?? _defaultTheme;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void didUpdateWidget(DynamicNumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
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
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: TextField(
            keyboardType: TextInputType.number,
            focusNode: _focusNode,
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
                right: 10,
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: "Type your answer here...",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: currentTheme.primaryColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: currentTheme.primaryColorDark, width: 2),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: currentTheme.errorColor),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: currentTheme.errorColor, width: 2),
              ),
            ),
            controller: _controller,
            onSubmitted: (String val) {
              widget.onSubmit();
            },
            onChanged: (String text) {
              widget.onTextChanged(text);
            },
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