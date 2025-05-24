import 'package:flutter/material.dart';
// PSS-10 Test Screen where users will answer questions
class PSSTestScreen extends StatefulWidget {
  const PSSTestScreen({super.key});

  @override
  _PSSTestScreenState createState() => _PSSTestScreenState();
}

class _PSSTestScreenState extends State<PSSTestScreen> {
  // List to hold the answers selected by the user
  List<int> answers = List.generate(10, (index) => 0); // Default all answers to 0 (Never)

  // List of PSS-10 questions
  final List<String> questions = [
    '1. In the last month, how often have you been upset because of something that happened unexpectedly?',
    '2. In the last month, how often have you felt that you were unable to control the important things in your life?',
    '3. In the last month, how often have you felt nervous and stressed?',
    '4. In the last month, how often have you felt confident about your ability to handle your personal problems?',
    '5. In the last month, how often have you felt that things were going your way?',
    '6. In the last month, how often have you found that you could not cope with all the things that you had to do?',
    '7. In the last month, how often have you been able to control irritations in your life?',
    '8. In the last month, how often have you felt that you were on top of things?',
    '9. In the last month, how often have you been angered because of things that were outside of your control?',
    '10. In the last month, how often have you felt difficulties were piling up so high that you could not overcome them?'
  ];

  // List of answer options
  final List<String> answerOptions = [
    'Never',
    'Almost Never',
    'Sometimes',
    'Fairly Often',
    'Very Often'
  ];

  // Function to calculate the total score
  int calculateScore() {
    return answers.reduce((value, element) => value + element);
  }

  // Function to interpret the score
  String interpretScore(int score) {
    if (score >= 0 && score <= 13) {
      return 'Low stress';
    } else if (score >= 14 && score <= 26) {
      return 'Moderate stress';
    } else if (score >= 27 && score <= 40) {
      return 'High stress';
    } else {
      return 'Very high stress';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PSS-10 Stress Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Make the entire body scrollable
          child: Column(
            children: <Widget>[
              ...List.generate(10, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(questions[index], style: const TextStyle(fontSize: 16)),
                    Column(
                      children: List.generate(5, (answerIndex) {
                        return RadioListTile<int>(
                          title: Text(answerOptions[answerIndex]),
                          value: answerIndex,
                          groupValue: answers[index],
                          onChanged: (value) {
                            setState(() {
                              answers[index] = value!;
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  int score = calculateScore();
                  String interpretation = interpretScore(score);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Your PSS-10 Score'),
                        content: Text('Your total score is: $score\n\n'
                            'Interpretation: $interpretation'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Submit Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


