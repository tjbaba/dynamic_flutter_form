import 'package:flutter/material.dart';
import '../models/form_theme.dart';

/// Email field widget matching your original design with theme support
class DynamicEmailField extends StatefulWidget {
  final String title;
  final String subTitle;
  final String value;
  final Function(String) onTextChanged;
  final VoidCallback onSubmit;
  final FormTheme? theme;
  final String? errorMessage;

  const DynamicEmailField({
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
  State<DynamicEmailField> createState() => _DynamicEmailFieldState();
}

class _DynamicEmailFieldState extends State<DynamicEmailField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  String? _validationError;
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
  void didUpdateWidget(DynamicEmailField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
      _validateEmail(widget.value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) return null;

    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid ? null : "Enter Valid Email";
  }

  void _onTextChanged(String text) {
    setState(() {
      _validationError = _validateEmail(text);
    });
    widget.onTextChanged(text);
  }

  @override
  Widget build(BuildContext context) {
    final displayError = widget.errorMessage ?? _validationError;

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
          child: TextFormField(
            focusNode: _focusNode,
            autofillHints: const [AutofillHints.email],
            textInputAction: TextInputAction.next,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
                right: 10,
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: "Type your email here...",
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _controller,
            onFieldSubmitted: (String val) {
              widget.onSubmit();
            },
            onChanged: _onTextChanged,
            // validator: _validateEmail,
          ),
        ),
        if (displayError != null) ...[
          const SizedBox(height: 8),
          Text(
            displayError,
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