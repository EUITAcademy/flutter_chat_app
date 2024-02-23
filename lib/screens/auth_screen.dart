import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  String userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat app'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 12,
        ),
        child: Column(
          children: [
            const SizedBox(height: 48),
            // Example of rotation animation,
            const Icon(
              Icons.stream,
              size: 54,
            ),
            const SizedBox(height: 48),
            TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String newText) {
                  userName = newText;
                }),
            const SizedBox(height: 20),
            // You can Detect Gestures with gesture detector.
            GestureDetector(
              onTap: () {
                if (userName.isEmpty) {
                  return;
                }

                // Arguments are generic(can be map or String or other type),
                // in onGenerateRoute we expect String, that is why we pass userName here
                Navigator.pushReplacementNamed(
                  context,
                  ChatScreen.routeName,
                  arguments: userName,
                );
              },
              // Animated container Example!
              // Change values, provide duration and it will animate automatically!
              child: Container(
                color: Colors.pinkAccent,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text('Enter chat')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}