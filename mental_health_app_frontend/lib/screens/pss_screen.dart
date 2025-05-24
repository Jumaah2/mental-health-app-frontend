import 'package:flutter/material.dart';

class PSSTestScreen extends StatefulWidget {
  const PSSTestScreen({super.key});

  @override
  _PSSTestScreenState createState() => _PSSTestScreenState();
}

class _PSSTestScreenState extends State<PSSTestScreen> {
  List<int> answers = List.generate(10, (index) => 0);

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

  final List<String> answerOptions = [
    'Never',
    'Almost Never',
    'Sometimes',
    'Fairly Often',
    'Very Often'
  ];

  int calculateScore() {
    return answers.reduce((value, element) => value + element);
  }

  String interpretScore(int score) {
    if (score <= 13) return 'Low stress';
    if (score <= 26) return 'Moderate stress';
    return 'High stress';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PSS-10 Stress Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(10, (index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          questions[index],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
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
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    int score = calculateScore();
                    String interpretation = interpretScore(score);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Your PSS-10 Score'),
                          content: Text(
                            'Your total score is: $score\n\nInterpretation: $interpretation',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Close'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Submit Test'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}