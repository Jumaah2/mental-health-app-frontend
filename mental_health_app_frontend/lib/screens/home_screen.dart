import 'package:flutter/material.dart';
//import 'package:mental_health_app_frontend/screens/therapy_screen.dart';
import 'package:mental_health_app_frontend/screens/therapy_test_screen.dart';
import 'package:mental_health_app_frontend/screens/chat_therapist_widget.dart';

import 'TherapistPredictionBehaviorScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Health App'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with image or icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 90,
                    color: Color(0xFF0288D1),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Welcome to Your Mental Health Journey',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: const Color(0xFF01579B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'We’re here to support your mental well-being with personalized assessments and therapist guidance.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: const Icon(Icons.person_search, color: Color(0xFF0288D1)),
                      title: Text(
                        'Behavioral Prediction',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF01579B),
                        ),
                      ),
                      subtitle: Text(
                        'Understand your mental health patterns',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TherapistPredictionBehaviorScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: const Icon(Icons.assessment, color: Color(0xFF0288D1)),
                      title: Text(
                        'Take Assessments',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF01579B),
                        ),
                      ),
                      subtitle: Text(
                        'Evaluate stress, anxiety, and depression',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TherapyTestScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: const Icon(Icons.chat, color: Color(0xFF0288D1)),
                      title: Text(
                        'Chat with Therapist',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF01579B),
                        ),
                      ),
                      subtitle: Text(
                        'Get support from our AI as therapist',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TherapistChatWidget(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TherapistPredictionBehaviorScreen(),
                        ),
                      );
                    },
                    child: const Text('Get Started Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}