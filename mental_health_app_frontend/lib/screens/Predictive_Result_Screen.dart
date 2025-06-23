import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mental_health_app_frontend/screens/chat_therapist_widget.dart';

class PredictiveResultScreen extends StatefulWidget {
  final dynamic prediction;

  const PredictiveResultScreen({super.key, required this.prediction});

  @override
  _PredictiveResultScreenState createState() => _PredictiveResultScreenState();
}

class _PredictiveResultScreenState extends State<PredictiveResultScreen> {
  String? _geminiAnalysis;
  bool _isLoading = true;

  final String _apiKey = 'AIzaSyBwxKyJ1aLE981hEk6JqAzj5179R4zPDns'; // Replace with your Gemini API key
  final String _endpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

  @override
  void initState() {
    super.initState();
    _fetchGeminiAnalysis();
  }

  Future<void> _fetchGeminiAnalysis() async {
    final stressLevel = widget.prediction['stress_level'] ?? 'Unknown';
    final stressScore = widget.prediction['stress_score']?.toString() ?? 'N/A';

    final prompt = '''
      Topic: Mental health and stress analysis. Act as an empathetic therapist. Provide a brief analysis (150-200 words) of the stress level "$stressLevel" (score: $stressScore). Identify potential mental health conditions or symptoms associated with this stress level, and suggest practical solutions and advice to manage it. Focus strictly on mental health and avoid physical health topics unless directly related to stress. Responses should be supportive and actionable.
    ''';

    try {
      final response = await http.post(
        Uri.parse('$_endpoint?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final analysis = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ??
            'Unable to generate analysis. Please try again later.';
        setState(() {
          _geminiAnalysis = analysis;
          _isLoading = false;
        });
      } else {
        setState(() {
          _geminiAnalysis = 'Failed to fetch analysis from Gemini API.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _geminiAnalysis = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stressLevel = widget.prediction['stress_level'] ?? 'Unknown';
    final stressScore = widget.prediction['stress_score']?.toString() ?? 'N/A';

    return Scaffold(
      appBar: AppBar(title: const Text('Predictive Result')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Stress Level: $stressLevel',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Stress Score: $stressScore',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'AI Therapist Analysis:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                        _geminiAnalysis ?? 'No analysis available.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Next Steps',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                'Connect with our therapist chatbot for personalized guidance or take additional assessments.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TherapistChatWidget(stressLevel: stressLevel),
              ),
            );
          },
          child: const Text('Connect with our Therapist Chatbot'),
        ),
      ),
    );
  }
}