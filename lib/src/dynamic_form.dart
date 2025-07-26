import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dynamic_flutter_form.dart';

/// Fresh DynamicForm written from scratch with allowBefore/allowAfter
class DynamicForm extends ConsumerStatefulWidget {
  final List<FormQuestion>? questions;
  final Function(List<FormResult>?) onSubmit;
  final Function(List<FormResult>?)? onChange;
  final List<FormResult>? results;
  final FormTheme? theme;
  final String? Function(FormResult)? validator;

  const DynamicForm({
    super.key,
    this.questions,
    required this.onSubmit,
    this.onChange,
    this.results,
    this.theme,
    this.validator,
  });

  @override
  ConsumerState<DynamicForm> createState() => _DynamicFormState();
}

class _DynamicFormState extends ConsumerState<DynamicForm> {
  List<FormResult> formResult = [];
  final PageStorageBucket _bucket = PageStorageBucket();
  final PageController pageController = PageController();
  int index = 0;

  FormTheme get currentTheme => widget.theme ?? const FormTheme();

  @override
  void initState() {
    super.initState();
    _initializeResults();
  }

  void _initializeResults() {
    if (widget.results != null) {
      formResult = [...widget.results!];
    }
    setState(() {});
  }

  void scrollToPage(int page) {
    pageController.animateToPage(
      page,
      duration: currentTheme.animationDuration,
      curve: Curves.easeInOut,
    );
  }

  bool _canProceed() {
    if (widget.questions == null || index >= widget.questions!.length) {
      return true;
    }

    final currentQuestion = widget.questions![index];
    final currentResult = _findResult(currentQuestion.id);

    // Special case for slider - allow to proceed silently
    if (currentQuestion.questionType == QuestionType.slider) {
      return true;
    }

    // Check if required field is empty
    if (!currentQuestion.isOptional &&
        currentResult.submission.trim().isEmpty) {
      _showError("This field is required");
      return false;
    }

    // Check validation
    if (!currentResult.isValid && currentResult.errorMessage != null) {
      _showError(currentResult.errorMessage!);
      return false;
    }

    return true;
  }

  FormResult _findResult(String elementId) {
    return formResult.firstWhere(
      (result) => result.elementId == elementId,
      orElse: () => FormResult(
        elementId: elementId,
        submission: "",
        type: "unknown",
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: currentTheme.errorColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void onNextTapped() {
    if (!_canProceed()) return;

    setState(() {
      index = index == widget.questions!.length - 1 ? index : index + 1;
    });
    scrollToPage(index);
  }

  void onBackTapped() {
    setState(() {
      index = index - 1;
    });
    scrollToPage(index);
  }

  void sendDataOnChange(data) {
    if (widget.onChange != null) {
      widget.onChange!(data);
    }
  }

  void addOrUpdateResult(FormResult newResult) {
    // Apply custom validation
    String? validationError;
    if (widget.validator != null) {
      validationError = widget.validator!(newResult);
    }

    final updatedResult = validationError != null
        ? newResult.copyWith(isValid: false, errorMessage: validationError)
        : newResult.copyWith(isValid: true, errorMessage: null);

    final existingIndex = formResult.indexWhere(
      (result) => result.elementId == updatedResult.elementId,
    );

    if (existingIndex != -1) {
      formResult[existingIndex] = updatedResult;
    } else {
      formResult.add(updatedResult);
    }

    setState(() {});
    sendDataOnChange(formResult);
  }

  Widget generateQuestionView(FormQuestion question) {
    final result = _findResult(question.id);

    switch (question.questionType) {
      case QuestionType.string:
        return DynamicTextFieldView(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          errorMessage: result.errorMessage,
          onTextChanged: (text) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: text,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.number:
        return DynamicNumberField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          errorMessage: result.errorMessage,
          onTextChanged: (text) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: text,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.email:
        return DynamicEmailField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          errorMessage: result.errorMessage,
          onTextChanged: (text) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: text,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.date:
        final dateQ = question as DateQuestion;
        return DynamicDateField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          initialDate: dateQ.initialDate,
          firstDate: dateQ.firstDate,
          lastDate: dateQ.lastDate,
          placeholder: dateQ.placeholder,
          allowBefore: dateQ.allowBefore,
          allowAfter: dateQ.allowAfter,
          errorMessage: result.errorMessage,
          onDateChanged: (dateString) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: dateString,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.time:
        return DynamicTimeField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          errorMessage: result.errorMessage,
          onTimeChanged: (timeString) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: timeString,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.dateTime:
        final dateTimeQ = question as DateTimeQuestion;
        return DynamicDateTimeField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          initialDateTime: dateTimeQ.initialDateTime,
          firstDate: dateTimeQ.firstDate,
          lastDate: dateTimeQ.lastDate,
          placeholder: dateTimeQ.placeholder,
          allowBefore: dateTimeQ.allowBefore,
          allowAfter: dateTimeQ.allowAfter,
          errorMessage: result.errorMessage,
          onDateTimeChanged: (dateTimeString) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: dateTimeString,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.slider:
        final sliderQ = question as SliderQuestion;
        return DynamicSliderField(
          value: result.submission.isNotEmpty
              ? result.submission
              : sliderQ.initialValue?.toString() ?? sliderQ.min.toString(),
          title: question.title,
          subTitle: question.text ?? "",
          theme: currentTheme,
          min: sliderQ.min,
          max: sliderQ.max,
          initialValue: sliderQ.initialValue,
          divisions: sliderQ.divisions,
          label: sliderQ.label,
          showLabels: sliderQ.showLabels,
          errorMessage: result.errorMessage,
          onSliderChanged: (sliderValue) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: sliderValue,
              type: question.questionType.name,
            ));
          },
          onSubmit: onNextTapped,
        );

      case QuestionType.singleChoice:
        final singleQ = question as SingleChoiceQuestion;
        return DynamicSingleChoiceField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          options: singleQ.options,
          theme: currentTheme,
          onNextTapped: (selectedOption) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: selectedOption,
              type: question.questionType.name,
            ));
            onNextTapped();
          },
        );

      case QuestionType.multipleChoice:
        final multipleQ = question as MultipleChoiceQuestion;
        return DynamicMultipleChoiceField(
          value: result.submission,
          title: question.title,
          subTitle: question.text ?? "",
          options: multipleQ.options,
          theme: currentTheme,
          onChoiceSelected: (selectedOptions) {
            addOrUpdateResult(FormResult(
              elementId: question.id,
              submission: selectedOptions,
              type: question.questionType.name,
            ));
          },
        );

      default:
        return Container(
          child: Text('Unsupported question type: ${question.questionType}'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questions == null || widget.questions!.isEmpty) {
      return Scaffold(
        backgroundColor: currentTheme.backgroundColor,
        body: const Center(
          child: Text(
            'No questions to display',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: currentTheme.backgroundColor,
        foregroundColor: currentTheme.primaryColor,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 8,
                      color: Colors.grey,
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final totalQuestions = widget.questions?.length ?? 1;
                        final validIndex = (index >= 0) ? index : 0;

                        double calculatedWidth = (validIndex + 1) /
                            totalQuestions *
                            constraints.maxWidth;
                        if (calculatedWidth.isInfinite ||
                            calculatedWidth.isNaN) {
                          calculatedWidth = constraints.maxWidth;
                        }

                        return AnimatedContainer(
                          duration: currentTheme.animationDuration,
                          curve: Curves.linear,
                          width: calculatedWidth,
                          height: 8,
                          color: currentTheme.primaryColor,
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageStorage(
        bucket: _bucket,
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.questions!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final question = widget.questions![index];
            return Container(
              key: PageStorageKey(index),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      generateQuestionView(question),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          index == 0
                              ? const SizedBox()
                              : InkWell(
                                  onTap: onBackTapped,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          currentTheme.borderRadius),
                                      color: currentTheme.primaryColorDark,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                        color: currentTheme.backgroundColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(width: index == 0 ? 0 : 10),
                          InkWell(
                            onTap: () {
                              index == widget.questions!.length - 1
                                  ? widget.onSubmit(formResult)
                                  : onNextTapped();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    currentTheme.borderRadius),
                                color: currentTheme.primaryColorDark,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  Text(
                                    index == widget.questions!.length - 1
                                        ? "Finish"
                                        : 'Ok',
                                    style: TextStyle(
                                      color: currentTheme.backgroundColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.check,
                                    color: currentTheme.backgroundColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
