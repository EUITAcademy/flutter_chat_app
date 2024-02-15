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
        leading: const Icon(Icons.stream),
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
            TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (String newText) {
                  if (newText.isNotEmpty) {
                    // No need to setState,
                    // Because we don't use userName in widget
                    // Hence we don't need to rebuild the screen
                    userName = newText;
                  }
                }),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // Arguments are generic(can be map or String or other type),
                // in onGenerateRoute we expect String, that is why we pass userName here
                Navigator.pushNamed(
                  context,
                  ChatScreen.routeName,
                  arguments: userName,
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Enter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
