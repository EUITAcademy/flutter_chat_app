import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // Animating rotation on start
  double turns = 0.0;
  void _changeRotation() {
    setState(() => turns = 3);
  }

  @override
  void initState() {
    super.initState();
    // addPostFrameCallback ensures
    // we call action inside the callback after widget is build!
    // Otherwise _scrollController will throw error.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _changeRotation();
    });
  }

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
            AnimatedRotation(
              turns: turns,
              duration: const Duration(seconds: 3),
              curve: Curves.ease,
              child: const Icon(
                Icons.stream,
                size: 54,
              ),
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
                  // Changing color of the button
                  setState(() {});
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
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color:
                    userName.isNotEmpty ? Colors.deepPurple : Colors.pinkAccent,
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
