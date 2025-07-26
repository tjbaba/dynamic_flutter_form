# Dynamic Flutter Form 🚀

**Developer:** [Talha Javed](https://talha-javed-ch.web.app/) | **GitHub:** [@talhajaved](https://github.com/tjbaba)

A beautiful, highly customizable dynamic form package for Flutter with flashing animations, comprehensive validation, multiple field types, and your favorite original UI design intact.

## 🎬 Preview

![Dynamic Form Demo](https://raw.githubusercontent.com/tjbaba/dynamic_flutter_form/refs/heads/main/video/video.gif)

## ✨ Features

- 🎨 **9 Field Types**: Text, Email, Number, Date, Time, DateTime, Slider, Single Choice, Multiple Choice
- 🌈 **8 Predefined Themes**: Blue, Purple, Green, Orange, Pink, Teal, Indigo, Red + Custom colors
- ✨ **Signature Flashing Animations**: Eye-catching selection animations on choice fields
- ✅ **Smart Validation**: Built-in validation + custom validator functions
- 📅 **Smart Date Controls**: `allowBefore`/`allowAfter` for DOB, appointments, etc.
- 🎯 **Progress Tracking**: Animated progress bar showing form completion
- 📱 **Responsive Design**: Works beautifully on all screen sizes
- 🔧 **Easy Integration**: Simple API with comprehensive documentation

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  dynamic_flutter_form: ^1.0.0
  flutter_riverpod: ^2.4.9  # Required for state management
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dynamic_flutter_form/dynamic_flutter_form.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questions = [
      StringQuestion(
        id: 'name',
        title: 'What\'s your name?',
        text: 'Please enter your full name',
      ),
      EmailQuestion(
        id: 'email',
        title: 'Email Address',
        text: 'We\'ll use this to contact you',
      ),
      SingleChoiceQuestion(
        id: 'color',
        title: 'Favorite Color',
        text: 'Choose your preferred color',
        options: ['Red', 'Blue', 'Green', 'Yellow'],
      ),
    ];

    return Scaffold(
      body: DynamicForm(
        questions: questions,
        onSubmit: (results) {
          print('Form submitted: $results');
          // Handle form submission
        },
        onChange: (results) {
          print('Form changed: $results');
          // Handle real-time changes
        },
      ),
    );
  }
}
```

## 📝 Field Types Guide

### 1. 📝 Text Field

```dart
StringQuestion(
  id: 'description',
  title: 'Tell us about yourself',
  text: 'Write a brief description',
  placeholder: 'Enter your bio here...',
  maxLength: 500,
  multiline: true,
  isOptional: false,
)
```

**Properties:**
- `maxLength`: Character limit
- `minLength`: Minimum characters required
- `placeholder`: Hint text
- `multiline`: Single or multi-line input

### 2. 📧 Email Field

```dart
EmailQuestion(
  id: 'email',
  title: 'Email Address',
  text: 'We\'ll send updates here',
  placeholder: 'your.email@example.com',
  isOptional: false,
)
```

**Features:**
- Built-in email validation
- Autocomplete hints
- Real-time validation feedback

### 3. 🔢 Number Field

```dart
NumberQuestion(
  id: 'age',
  title: 'Your Age',
  text: 'Enter your age in years',
  min: 13,
  max: 120,
  allowDecimals: false,
  placeholder: '25',
)
```

**Properties:**
- `min`/`max`: Value constraints
- `allowDecimals`: Allow decimal numbers
- Automatic validation

### 4. 📅 Date Field

```dart
DateQuestion(
  id: 'birthdate',
  title: 'Date of Birth',
  text: 'Select your birth date',
  allowBefore: true,   // Allow past dates
  allowAfter: false,   // Don't allow future dates (perfect for DOB!)
  placeholder: 'Select your birth date',
  firstDate: DateTime(1900),
  lastDate: DateTime.now(),
)
```

**Smart Date Control:**
- `allowBefore: false` → Only future dates (appointments)
- `allowAfter: false` → Only past dates (date of birth)
- Both `false` → Only today can be selected

### 5. ⏰ Time Field

```dart
TimeQuestion(
  id: 'meeting_time',
  title: 'Preferred Meeting Time',
  text: 'When would you like to meet?',
  initialTime: TimeOfDay(hour: 14, minute: 30),
  placeholder: 'Select preferred time',
)
```

**Features:**
- Native time picker
- 12/24 hour format support
- Persistent value storage

### 6. 📅⏰ DateTime Field

```dart
DateTimeQuestion(
  id: 'appointment',
  title: 'Appointment Date & Time',
  text: 'Choose your preferred slot',
  allowBefore: false,  // No past appointments
  allowAfter: true,    // Allow future appointments
  placeholder: 'Select appointment date and time',
)
```

**Perfect for:**
- Appointment booking
- Event scheduling
- Deadline setting

### 7. 🎚️ Slider Field

```dart
SliderQuestion(
  id: 'satisfaction',
  title: 'Satisfaction Rating',
  text: 'Rate your experience',
  min: 0,
  max: 10,
  initialValue: 5,
  divisions: 10,
  label: 'Rating',
  showLabels: true,
)
```

**Properties:**
- `divisions`: Number of discrete steps
- `showLabels`: Show min/max labels
- Special validation: Never blocks user progression

### 8. 🔘 Single Choice Field

```dart
SingleChoiceQuestion(
  id: 'experience',
  title: 'Programming Experience',
  text: 'How long have you been coding?',
  options: [
    'Less than 1 year',
    '1-3 years', 
    '3-5 years',
    '5-10 years',
    'More than 10 years',
  ],
  fieldKey: 'experience_level', // Optional
)
```

**Features:**
- Signature flashing animation on selection
- Auto-advance to next question
- Alphabetic indicators (A, B, C...)

### 9. ☑️ Multiple Choice Field

```dart
MultipleChoiceQuestion(
  id: 'skills',
  title: 'Programming Languages',
  text: 'Select all you know (max 5)',
  options: [
    'Dart/Flutter',
    'JavaScript', 
    'Python',
    'Java',
    'Swift',
    'Kotlin',
  ],
  maxSelections: 5,
  minSelections: 1,
)
```

**Properties:**
- `maxSelections`: Limit number of choices
- `minSelections`: Require minimum selections
- Flashing animation on toggle

## 🎨 Theming & Customization

### Predefined Themes

```dart
DynamicForm(
  questions: questions,
  theme: FormTheme.purple,        // Purple theme
  // OR
  theme: FormTheme.blue,          // Blue theme  
  // OR
  theme: FormTheme.green,         // Green theme
  onSubmit: (results) {},
)
```

**Available Themes:**
- `FormTheme.blue` 💙
- `FormTheme.purple` 💜
- `FormTheme.green` 💚
- `FormTheme.orange` 🧡
- `FormTheme.pink` 💖
- `FormTheme.teal` 💛
- `FormTheme.indigo` 💙
- `FormTheme.red` ❤️

### Custom Theme

```dart
DynamicForm(
  questions: questions,
  theme: FormTheme(
    primaryColor: Colors.deepOrange,
    primaryColorDark: Colors.deepOrange[800]!,
    backgroundColor: Colors.white,
    titleColor: Colors.black87,
    subtitleColor: Colors.grey[600]!,
    errorColor: Colors.red,
    borderRadius: 12.0,
    animationDuration: Duration(milliseconds: 300),
  ),
  onSubmit: (results) {},
)
```

### Quick Theme from Color

```dart
DynamicForm(
  questions: questions,
  theme: FormTheme.fromColor(Colors.indigo), // Auto-generates theme
  onSubmit: (results) {},
)
```

## ✅ Validation & Error Handling

### Built-in Validation

- **Email**: Automatic email format validation
- **Required Fields**: Set `isOptional: false`
- **Number Constraints**: Min/max validation
- **Date Constraints**: Smart date validation with `allowBefore`/`allowAfter`

### Custom Validation

```dart
DynamicForm(
  questions: questions,
  validator: (result) {
    switch (result.elementId) {
      case 'age':
        final age = int.tryParse(result.submission);
        if (age != null && age < 18) {
          return 'Must be 18 or older';
        }
        break;
        
      case 'name':
        if (result.submission.length < 2) {
          return 'Name must be at least 2 characters';
        }
        if (!result.submission.contains(' ')) {
          return 'Please enter first and last name';
        }
        break;
        
      case 'satisfaction':
        final rating = double.tryParse(result.submission);
        if (rating != null && rating < 3) {
          return 'We\'d love to hear how we can improve!';
        }
        break;
    }
    return null; // No error
  },
  onSubmit: (results) {},
)
```

**Validation Features:**
- Real-time validation feedback
- Custom error messages
- Prevents progression on invalid required fields
- Special handling for sliders (shows message but allows progression)

## 🎯 Form Results & Data Handling

### FormResult Structure

```dart
class FormResult {
  final String elementId;    // Question ID
  final String submission;   // User's answer
  final String? type;        // Field type
  final bool isValid;        // Validation status
  final String? errorMessage; // Error if invalid
}
```

### Handling Results

```dart
void _onFormSubmit(List<FormResult>? results) {
  if (results == null) return;
  
  for (final result in results) {
    print('Question: ${result.elementId}');
    print('Answer: ${result.submission}');
    print('Valid: ${result.isValid}');
    
    // Process specific fields
    switch (result.elementId) {
      case 'email':
        String userEmail = result.submission;
        // Send welcome email
        break;
        
      case 'skills':
        List<String> selectedSkills = result.submission.split(", ");
        // Process selected skills
        break;
        
      case 'appointment':
        DateTime appointmentTime = DateTime.parse(result.submission);
        // Book appointment
        break;
    }
  }
}
```

### Data Format Examples

```dart
// Text/Email/Number results
FormResult(elementId: 'name', submission: 'John Doe', type: 'string')
FormResult(elementId: 'email', submission: 'john@example.com', type: 'email')
FormResult(elementId: 'age', submission: '25', type: 'number')

// Date/Time results  
FormResult(elementId: 'birthdate', submission: '1998-05-15T00:00:00.000Z', type: 'date')
FormResult(elementId: 'meeting_time', submission: '14:30', type: 'time')
FormResult(elementId: 'appointment', submission: '2024-12-25T14:30:00.000Z', type: 'dateTime')

// Choice results
FormResult(elementId: 'color', submission: 'Blue', type: 'singleChoice')
FormResult(elementId: 'skills', submission: 'Dart/Flutter, JavaScript, Python', type: 'multipleChoice')

// Slider result
FormResult(elementId: 'satisfaction', submission: '8.0', type: 'slider')
```

## 🎮 Advanced Usage

### Real-time Form State

```dart
class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  List<FormResult> currentResults = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DynamicForm(
        questions: questions,
        onChange: (results) {
          setState(() {
            currentResults = results ?? [];
          });
          
          // Auto-save progress
          _saveProgress(currentResults);
          
          // Analytics tracking
          _trackFormProgress(currentResults.length, questions.length);
        },
        onSubmit: _handleSubmit,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showProgress(),
        label: Text('Progress: ${currentResults.length}/${questions.length}'),
        icon: Icon(Icons.info),
      ),
    );
  }
}
```

### Conditional Questions

```dart
List<FormQuestion> getDynamicQuestions() {
  List<FormQuestion> questions = [
    StringQuestion(id: 'name', title: 'Your Name'),
    SingleChoiceQuestion(
      id: 'has_experience',
      title: 'Do you have programming experience?',
      options: ['Yes', 'No'],
    ),
  ];
  
  // Add conditional questions based on previous answers
  final hasExperience = currentResults
      .firstWhere((r) => r.elementId == 'has_experience', orElse: () => FormResult(elementId: '', submission: ''))
      .submission;
      
  if (hasExperience == 'Yes') {
    questions.add(MultipleChoiceQuestion(
      id: 'languages',
      title: 'Which languages do you know?',
      options: ['Dart', 'JavaScript', 'Python', 'Java'],
    ));
  }
  
  return questions;
}
```

### Form Persistence

```dart
import 'package:shared_preferences/shared_preferences.dart';

class FormPersistence {
  static const String _key = 'form_progress';
  
  static Future<void> saveProgress(List<FormResult> results) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = results.map((r) => r.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }
  
  static Future<List<FormResult>> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    
    if (jsonString == null) return [];
    
    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => FormResult.fromJson(json)).toList();
  }
  
  static Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
```

## 🛠️ Common Use Cases

### 1. User Registration Form

```dart
final registrationQuestions = [
  StringQuestion(
    id: 'full_name',
    title: 'Full Name',
    text: 'Enter your first and last name',
    isOptional: false,
  ),
  EmailQuestion(
    id: 'email',
    title: 'Email Address',
    text: 'We\'ll send a verification email',
    isOptional: false,
  ),
  DateQuestion(
    id: 'birth_date',
    title: 'Date of Birth',
    text: 'We need this to verify your age',
    allowAfter: false, // No future birth dates
    isOptional: false,
  ),
  SingleChoiceQuestion(
    id: 'gender',
    title: 'Gender',
    text: 'Optional - helps us personalize your experience',
    options: ['Male', 'Female', 'Other', 'Prefer not to say'],
    isOptional: true,
  ),
];
```

### 2. Customer Feedback Survey

```dart
final feedbackQuestions = [
  SliderQuestion(
    id: 'overall_satisfaction',
    title: 'Overall Satisfaction',
    text: 'How satisfied are you with our service?',
    min: 1,
    max: 10,
    divisions: 9,
    label: 'Rating',
  ),
  MultipleChoiceQuestion(
    id: 'liked_features',
    title: 'What did you like most?',
    text: 'Select all that apply',
    options: ['Easy to use', 'Fast', 'Good design', 'Helpful support'],
  ),
  StringQuestion(
    id: 'suggestions',
    title: 'Suggestions for Improvement',
    text: 'How can we make our service better?',
    multiline: true,
    maxLength: 500,
    isOptional: true,
  ),
];
```

### 3. Appointment Booking Form

```dart
final appointmentQuestions = [
  StringQuestion(
    id: 'patient_name',
    title: 'Patient Name',
    isOptional: false,
  ),
  EmailQuestion(
    id: 'contact_email',
    title: 'Contact Email',
    isOptional: false,
  ),
  DateTimeQuestion(
    id: 'preferred_time',
    title: 'Preferred Appointment Time',
    text: 'Select your preferred date and time',
    allowBefore: false, // No past appointments
    allowAfter: true,
    isOptional: false,
  ),
  SingleChoiceQuestion(
    id: 'appointment_type',
    title: 'Type of Appointment',
    options: ['Consultation', 'Follow-up', 'Emergency', 'Routine Check-up'],
    isOptional: false,
  ),
];
```

## 🐛 Troubleshooting

### Common Issues

1. **Form not showing questions**
   ```dart
   // ❌ Wrong
   DynamicForm(questions: null, onSubmit: (r) {})
   
   // ✅ Correct  
   DynamicForm(questions: myQuestions, onSubmit: (r) {})
   ```

2. **Results not persisting when navigating back**
   ```dart
   // ✅ Make sure to pass results back to the form
   DynamicForm(
     questions: questions,
     results: savedResults, // Important!
     onChange: (results) => savedResults = results,
     onSubmit: (results) {},
   )
   ```

3. **Validation not working**
   ```dart
   // ✅ Make sure validator returns null for valid inputs
   validator: (result) {
     if (result.submission.isEmpty) {
       return 'This field is required';
     }
     return null; // Important: return null for valid
   }
   ```

4. **Theme not applying**
   ```dart
   // ❌ Wrong
   DynamicForm(questions: questions, onSubmit: (r) {})
   
   // ✅ Correct
   DynamicForm(
     questions: questions,
     theme: FormTheme.blue, // Add theme
     onSubmit: (r) {},
   )
   ```

### Performance Tips

- Keep question lists reasonably sized (< 50 questions)
- Use `isOptional: true` for non-critical fields
- Implement form persistence for long forms
- Consider breaking very long forms into multiple steps

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Setup

```bash
git clone https://github.com/tjbaba/dynamic_flutter_form.git
cd dynamic_flutter_form
flutter pub get
cd example
flutter run
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with ❤️ for the Flutter community
- Inspired by the need for beautiful, functional forms
- Special thanks to all contributors and users

## 📱 More Examples

Check out our [example app](example/) for complete implementation examples including:

- User registration forms
- Survey and feedback forms
- Appointment booking systems
- Multi-step onboarding flows
- Dynamic conditional questions

## 🔗 Links

- 📦 [Pub.dev Package](https://pub.dev/packages/dynamic_flutter_form)
- 📖 [API Documentation](https://pub.dev/documentation/dynamic_flutter_form/latest/)
- 🐛 [Issue Tracker](https://github.com/tjbaba/dynamic_flutter_form/issues)
- 💬 [Discussions](https://github.com/tjbaba/dynamic_flutter_form/discussions)

---

**Made with ❤️ by [Your Name](https://github.com/tjbaba)**

*If this package helped you, please give it a ⭐ on GitHub!*