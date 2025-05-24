import 'package:flutter/material.dart';

class PHQ9TestScreen extends StatefulWidget {
  const PHQ9TestScreen({super.key});

  @override
  _PHQ9TestScreenState createState() => _PHQ9TestScreenState();
}

class _PHQ9TestScreenState extends State<PHQ9TestScreen> {
  List<int> answers = List.generate(9, (index) => 0);

  final List<String> questions = [
    '1. Little interest or pleasure in doing things?',
    '2. Feeling down, depressed, or hopeless?',
    '3. Trouble falling or staying asleep, or sleeping too much?',
    '4. Feeling tired or having little energy?',
    '5. Poor appetite or overeating?',
    '6. Feeling bad about yourself — or that you are a failure or have let yourself or your family down?',
    '7. Trouble concentrating on things, such as reading the newspaper or watching television?',
    '8. Moving or speaking so slowly that other people could have noticed? Or the opposite — being so fidgety or restless that you have been moving around a lot more than usual?',
    '9. Thoughts that you would be better off dead, or of hurting yourself in some way?'
  ];

  final List<String> answerOptions = [
    'Not at all',
    'Several days',
    'More than half the days',
    'Nearly every day'
  ];

  int calculateScore() {
    return answers.reduce((value, element) => value + element);
  }

  String interpretScore(int score) {
    if (score <= 4) return 'Minimal depression';
    if (score <= 9) return 'Mild depression';
    if (score <= 14) return 'Moderate depression';
    if (score <= 19) return 'Moderately severe depression';
    return 'Severe depression';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PHQ-9 Depression Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(9, (index) {
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
                          title: const Text('Your PHQ-9 Score'),
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