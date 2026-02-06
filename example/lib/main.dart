import 'package:flutter/material.dart';

import 'chat_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Chat AI Sample',
    theme: ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    builder: (context, child) {
      final width = MediaQuery.of(context).size.width;
      final isDesktop = width > 1200;

      return Theme(
        data: Theme.of(context).copyWith(
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              minimumSize:
                  isDesktop
                      ? Size(24, 24) // Più piccolo desktop
                      : Size(48, 48), // Standard mobile
              padding: isDesktop ? EdgeInsets.all(2) : EdgeInsets.all(8),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding:
                  isDesktop
                      ? EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                      : EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
        child: child!,
      );
    },
    home: ChatPage(),
  );
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Chat AI Sample'),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 46),
          child: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ),
      ],
    ),
    body: ChatView(),
  );
}
