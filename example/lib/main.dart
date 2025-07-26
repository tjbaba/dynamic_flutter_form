import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_flutter_form/dynamic_flutter_form.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FormExamplePage(),
    );
  }
}

class FormExamplePage extends StatefulWidget {
  const FormExamplePage({super.key});

  @override
  State<FormExamplePage> createState() => _FormExamplePageState();
}

class _FormExamplePageState extends State<FormExamplePage> {
  List<FormResult> currentResults = [];
  FormTheme currentTheme = FormTheme.blue;

  // Sample questions demonstrating all field types
  List<FormQuestion> get sampleQuestions => [
    const StringQuestion(
      id: 'name',
      title: 'What\'s your full name?',
      text: 'Please enter your first and last name',
    ),
    const EmailQuestion(
      id: 'email',
      title: 'Email Address',
      text: 'We\'ll use this to send you updates',
    ),
    const NumberQuestion(
      id: 'age',
      title: 'Your Age',
      text: 'Please enter your age in years',
    ),
    const DateQuestion(
      id: 'birthdate',
      title: 'Date of Birth',
      text: 'Select your birth date',
      placeholder: 'Select your birth date',
      allowAfter: false
    ),
    const SingleChoiceQuestion(
      id: 'experience',
      title: 'Programming Experience',
      text: 'How long have you been programming?',
      options: [
        'Less than 1 year',
        '1-3 years',
        '3-5 years',
        '5-10 years',
        'More than 10 years',
      ],
    ),
    const MultipleChoiceQuestion(
      id: 'skills',
      title: 'Programming Languages',
      text: 'Select all programming languages you know',
      options: [
        'Dart/Flutter',
        'JavaScript',
        'Python',
        'Java',
        'Swift',
        'Kotlin',
        'C++',
        'C#',
      ],
    ),
    const TimeQuestion(
      id: 'preferred_time',
      title: 'Preferred Contact Time',
      text: 'When would you like us to contact you?',
      placeholder: 'Select preferred time',
    ),
    const DateTimeQuestion(
      id: 'appointment',
      title: 'Appointment Date & Time',
      text: 'Choose your preferred appointment slot',
      placeholder: 'Select appointment date and time',
      allowBefore: false
    ),
    const SliderQuestion(
      id: 'satisfaction',
      title: 'Satisfaction Level',
      text: 'Rate your overall satisfaction',
      min: 0,
      max: 10,
      initialValue: 5,
      divisions: 10,
      label: 'Rating',
    ),

  ];

  void _onFormSubmit(List<FormResult>? results) {
    if (results == null) return;

    setState(() {
      currentResults = results;
    });

    // Show results dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Form Submitted Successfully!'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Here are your responses:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...results.map((result) {
                final question = sampleQuestions.firstWhere(
                      (q) => q.id == result.elementId,
                );
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          result.submission.isEmpty
                              ? '(No answer)'
                              : result.submission,
                          style: TextStyle(
                            color: result.submission.isEmpty
                                ? Colors.grey[600]
                                : Colors.black87,
                            fontStyle: result.submission.isEmpty
                                ? FontStyle.italic
                                : FontStyle.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String? _customValidator(FormResult result) {
    // Custom validation examples
    switch (result.elementId) {
      case 'age':
        if (result.submission.isNotEmpty) {
          final age = int.tryParse(result.submission);
          if (age != null && age < 13) {
            return 'Must be 13 or older';
          }
          if (age != null && age > 120) {
            return 'Please enter a valid age';
          }
        }
        break;
      case 'name':
        if (result.submission.length < 2) {
          return 'Name must be at least 2 characters long';
        }
        break;
      case 'satisfaction':
        if (result.submission.isNotEmpty) {
          final rating = double.tryParse(result.submission);
          if (rating != null && rating < 3) {
            return 'We appreciate your feedback. Could you tell us more?';
          }
        }
        break;
    }
    return null;
  }

  void _showThemeSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Form Theme'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildThemeOption('Blue', FormTheme.blue, Colors.blue),
              _buildThemeOption('Purple', FormTheme.purple, Colors.purple),
              _buildThemeOption('Green', FormTheme.green, Colors.green),
              _buildThemeOption('Orange', FormTheme.orange, Colors.orange),
              _buildThemeOption('Pink', FormTheme.pink, Colors.pink),
              _buildThemeOption('Teal', FormTheme.teal, Colors.teal),
              _buildThemeOption('Indigo', FormTheme.indigo, Colors.indigo),
              _buildThemeOption('Red', FormTheme.red, Colors.red),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String name, FormTheme theme, Color color) {
    final isSelected = currentTheme == theme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
      ),
      title: Text(name),
      onTap: () {
        setState(() {
          currentTheme = theme;
        });
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form Example'),
        backgroundColor: currentTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _showThemeSelector,
            icon: const Icon(Icons.palette),
            tooltip: 'Choose Theme',
          ),
        ],
      ),
      body: DynamicForm(
        questions: sampleQuestions,
        theme: currentTheme,
        validator: _customValidator,
        onSubmit: _onFormSubmit,
        onChange: (results) {
          if (results != null) {
            setState(() {
              currentResults = results;
            });
            print('Form progress: ${results.length}/${sampleQuestions.length}');
          }
        },
        results: currentResults,
      ),
      floatingActionButton: currentResults.isNotEmpty
          ? FloatingActionButton.extended(
        backgroundColor: currentTheme.primaryColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Current Progress'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Answered: ${currentResults.length}/${sampleQuestions.length} questions'),
                  const SizedBox(height: 16),
                  const Text('Available Field Types:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('✅ Text Input'),
                  const Text('✅ Email Input (with validation)'),
                  const Text('✅ Number Input'),
                  const Text('✅ Date Picker'),
                  const Text('✅ Time Picker'),
                  const Text('✅ DateTime Picker'),
                  const Text('✅ Slider Input'),
                  const Text('✅ Single Choice'),
                  const Text('✅ Multiple Choice'),
                  const Text('✅ Form Validation'),
                  const Text('✅ Custom Themes'),
                  const Text('✅ Flashing Animations'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        label: Text('${currentResults.length}/${sampleQuestions.length}'),
        icon: const Icon(Icons.info_outline),
      )
          : null,
    );
  }
}