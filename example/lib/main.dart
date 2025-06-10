import 'package:flutter/material.dart';

import 'app_theme.dart';
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
    theme: AppTheme.light,
    themeMode: ThemeMode.dark,
    darkTheme: AppTheme.dark,
    home: ChatPage(),
  );
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text('Chat AI Sample')), body: ChatView());
}
