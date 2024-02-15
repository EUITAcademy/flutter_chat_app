import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/auth_screen.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: const AuthScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == AuthScreen.routeName) {
          return MaterialPageRoute(
            builder: (_) => const AuthScreen(),
          );
        }
        if (settings.name == ChatScreen.routeName) {
          // Retrieve the userName.
          final userName = settings.arguments as String;
          // We can hide argument with _ if we don't need it
          return MaterialPageRoute(
            builder: (_) => ChatScreen(userName: userName),
          );
        }
        // implement onUnknown route to handle unknown routes
        return null;
      },
    );
  }
}
