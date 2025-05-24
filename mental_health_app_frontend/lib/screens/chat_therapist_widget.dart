import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TherapistChatWidget extends StatefulWidget {
  const TherapistChatWidget({Key? key}) : super(key: key);

  @override
  State<TherapistChatWidget> createState() => _TherapistChatWidgetState();
}

class _TherapistChatWidgetState extends State<TherapistChatWidget> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final String apiKey = "AIzaSyBwqKyJ1aLE981hEk6JqAzj5179R4zPDns";
  final String endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

  bool _isLoading = false;

  Future<void> sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": userMessage});
      _controller.clear();
      _isLoading = true;
    });

    final contextPrompt =
        "Topic: Mental health and therapy. Respond as a calm and empathetic therapist. Brief and supportive responses only. $userMessage";

    try {
      final response = await http.post(
        Uri.parse('$endpoint?key=$apiKey'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": contextPrompt}
              ]
            }
          ]
        }),
      );

      final data = jsonDecode(response.body);
      final reply = data['candidates']?[0]?['content']?['parts']?[0]?['text'] ??
          "I'm here to support you. Can you tell me more?";

      setState(() {
        _messages.add({"role": "bot", "text": reply});
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({"role": "bot", "text": "Sorry, something went wrong. Please try again later."});
        _isLoading = false;
      });
    }
  }

  Widget buildMessage(String role, String text) {
    final isUser = role == "user";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isUser ? Theme.of(context).primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Therapist Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: _messages
                  .map((msg) => buildMessage(msg['role']!, msg['text']!))
                  .toList(),
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Talk to me...",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send, size: 20),
                  label: const Text("Send"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}