import 'package:chat_impl/impl.dart';
import 'package:chat_ui/ui.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ChatDomainDependencyProvider.register();
  ChatModuleDependencyProvider.register();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.indigoAccent)),
      home: const HomeScreen(),
    );
  }
}
