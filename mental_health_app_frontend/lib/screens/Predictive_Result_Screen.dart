import 'package:flutter/material.dart';
import 'package:mental_health_app_frontend/screens/chat_therapist_widget.dart';

class PredictiveResultScreen extends StatelessWidget {
  const PredictiveResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Predictive Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Predictive Results',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'The full predictive results will be shown here.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 350),
            Text(
              '',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),

            ),
            const SizedBox(height: 10),
            Text(
              'Connect with our therapist chatbot for personalized guidance or take additional assessments.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TherapistChatWidget(),
              ),
            );
          },
          child: const Text('Connect with our Therapist Chatbot'),
        ),
      ),
    );
  }
}