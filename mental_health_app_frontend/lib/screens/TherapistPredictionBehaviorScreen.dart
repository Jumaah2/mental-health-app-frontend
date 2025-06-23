import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mental_health_app_frontend/modals/userdata.dart';
import 'package:mental_health_app_frontend/screens/therapy_test_screen.dart';

class TherapistPredictionBehaviorScreen extends StatefulWidget {
  const TherapistPredictionBehaviorScreen({super.key});

  @override
  _TherapistPredictionBehaviorScreenState createState() => _TherapistPredictionBehaviorScreenState();
}

class _TherapistPredictionBehaviorScreenState extends State<TherapistPredictionBehaviorScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserData _userData = UserData();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Navigate to TherapyTestScreen and wait for test scores
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TherapyTestScreen(),
        ),
      );

      if (result != null && result is Map<String, int>) {
        // Combine user data and test scores
        final data = {
          ..._userData.toMap(),
          'gad7_score': result['gad7'] ?? 0,
          'phq9_score': result['phq9'] ?? 0,
          'pss_score': result['pss'] ?? 0,
        };

        // Send to stress predictive model API
        final response = await http.post(
          Uri.parse('http://192.168.1.150/api/v1/predict'), // Replace with your API endpoint
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final prediction = jsonDecode(response.body);
          // Navigate to PredictiveResultScreen with prediction
          Navigator.pushNamed(context, '/predictive_result', arguments: prediction);
        } else {
          setState(() {
            _errorMessage = 'Failed to get prediction. Please try again.';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Therapist Prediction Behavior')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tell Us About Yourself',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Sex'),
                  value: _userData.gender,
                  items: <String>['Male', 'Female']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.gender = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your gender' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Age Group'),
                  value: _userData.age,
                  items: <String>['18-24', '25-34', '35-44', '45-64', '65+']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.age = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your age group' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Social Life'),
                  value: _userData.socialLife,
                  items: <String>['Very dissatisfied', 'Dissatisfied', 'Neutral', 'Satisfied', 'Very satisfied']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.socialLife = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your social life level' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Social Media Usage'),
                  value: _userData.socialMediaUsage,
                  items: <String>[
                    'Less than 1hr',
                    '1-2hrs',
                    '2-4hrs',
                    '4-6hrs',
                    'More than 6hrs'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.socialMediaUsage = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your social media usage level' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Sleep Patterns'),
                  value: _userData.sleepPatterns,
                  items: <String>['Less than 6 hours', '6-8 hours', '8-10 hours', 'More than 10 hours']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.sleepPatterns = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your sleep patterns' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Academic Focus'),
                  value: _userData.academicFocus,
                  items: <String>['Less than 1 hr', '1-2hrs', '2-4hrs', 'More than 4hrs']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _userData.academicFocus = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select your academic focus level' : null,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitData,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit'),
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Error: $_errorMessage',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}