import 'package:flutter/material.dart';

class GAD7TestScreen extends StatefulWidget {
  const GAD7TestScreen({super.key});

  @override
  _GAD7TestScreenState createState() => _GAD7TestScreenState();
}

class _GAD7TestScreenState extends State<GAD7TestScreen> {
  List<int> answers = List.generate(7, (index) => 0);

  final List<String> questions = [
    '1. Feeling nervous, anxious, or on edge?',
    '2. Not being able to stop or control worrying?',
    '3. Worrying too much about different things?',
    '4. Trouble relaxing?',
    '5. Being so restless that it is hard to sit still?',
    '6. Becoming easily annoyed or irritable?',
    '7. Feeling afraid as if something awful might happen?'
  ];

  final List<String> answerOptions = [
    'Not at all',
    'More than half the days',
    'Nearly every day',
    'Several days',
  ];

  int calculateScore() {
    return answers.reduce((value, element) => value + element);
  }

  String interpretScore(int score) {
    if (score <= 4) return 'Minimal anxiety';
    if (score <= 9) return 'Mild anxiety';
    if (score <= 14) return 'Moderate anxiety';
    if (score <= 19) return 'Moderately severe anxiety';
    return 'Severe anxiety';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GAD-7 Anxiety Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(7, (index) {
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
                          children: List.generate(4, (answerIndex) {
                            return RadioListTile<int>(
                              title: Text(answerOptions[answerIndex]),
                              value: answerIndex,
                              groupValue: answers[index],
                              onChanged: (value) {
                                setState(()  {
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
                          title: const Text('Your GAD-7 Score'),
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