import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app_frontend/screens/TherapistPredictionBehaviorScreen.dart';
import 'package:mental_health_app_frontend/screens/home_screen.dart';
import 'package:mental_health_app_frontend/screens/predictive_result_screen.dart';
import 'package:mental_health_app_frontend/screens/therapy_test_screen.dart';
import 'package:mental_health_app_frontend/screens/chat_therapist_widget.dart';

void main() {
  runApp(DevicePreview(builder: (context) => const MentalHealthApp()));
}

class MentalHealthApp extends StatelessWidget {
  const MentalHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0288D1),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0288D1),
          foregroundColor: Colors.white,
          elevation: 2,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0288D1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          filled: true,
          fillColor: Color(0xFFE0F7FA),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF01579B),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/predictive_result': (context) => PredictiveResultScreen(
          prediction: ModalRoute.of(context)!.settings.arguments,
        ),
        '/therapist_prediction': (context) => const TherapistPredictionBehaviorScreen(),
        '/therapy_test': (context) => const TherapyTestScreen(),
        '/chat_therapist': (context) => const TherapistChatWidget(),
      },
    );
  }
}
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mental Health App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome to Your Mental Health Journey',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineSmall,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'We are here to support your mental well-being.\nTap below to connect with a therapist or get behavior predictions.',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const TherapistPredictionBehaviorScreen(),
//                   ),
//                 );
//               },
//               child: const Text('Get Started'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }