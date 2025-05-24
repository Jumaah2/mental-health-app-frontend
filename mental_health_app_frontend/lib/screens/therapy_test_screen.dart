import 'package:flutter/material.dart';
import 'package:mental_health_app_frontend/screens/gad7_test_screen.dart';
import 'package:mental_health_app_frontend/screens/ph9_test_sceen.dart';
import 'package:mental_health_app_frontend/screens/pss_test_screen.dart';
import 'package:mental_health_app_frontend/screens/predictive_result_screen.dart';

class TherapyTestScreen extends StatelessWidget {
  const TherapyTestScreen({super.key});

  void _showGAD7InfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About GAD-7 Anxiety Test'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Generalized Anxiety Disorder 7 (GAD-7) is a self-report questionnaire used to assess the severity of anxiety symptoms.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'How to Use:\n\nThe GAD-7 consists of 7 questions related to anxiety symptoms experienced in the past two weeks. Each question is rated on a 4-point scale from "Not at all" to "Nearly every day".',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Usefulness:\n\nThe GAD-7 is a quick tool to evaluate anxiety severity and track changes over time.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
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
  }

  void _showPHQ9InfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About PHQ-9 Depression Test'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Patient Health Questionnaire-9 (PHQ-9) is a tool to screen for depression severity.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'How to Use:\n\nThe PHQ-9 consists of 9 questions related to depressive symptoms over the past two weeks. Each question is rated on a 4-point scale from "Not at all" to "Nearly every day".',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Usefulness:\n\nThe PHQ-9 helps evaluate depression severity and monitor progress.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
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
  }

  void _showPSSInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('About Perceived Stress Scale (PSS)'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Perceived Stress Scale (PSS) measures how stressful situations are perceived.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'How to Use:\n\nThe PSS consists of 10 questions about feelings and thoughts in the last month, rated on a 5-point scale from "Never" to "Very Often".',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Usefulness:\n\nThe PSS helps assess stress levels and guide interventions.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Therapy Prediction Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Take an Assessment',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'GAD-7 Anxiety Test',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Assess your anxiety levels',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => _showGAD7InfoDialog(context),
                      child: const Text('Read'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GAD7TestScreen()),
                        );
                      },
                      child: const Text('Test'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'PHQ-9 Depression Test',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Assess your depression levels',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => _showPHQ9InfoDialog(context),
                      child: const Text('Read'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PHQ9TestScreen()),
                        );
                      },
                      child: const Text('Test'),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(
                  'PSS-10 Stress Test',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'Assess your stress levels',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => _showPSSInfoDialog(context),
                      child: const Text('Read'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PSSTestScreen()),
                        );
                      },
                      child: const Text('Test'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PredictiveResultScreen()),
            );
          },
          child: const Text('View Predictive Results'),
        ),
      ),
    );
  }
}