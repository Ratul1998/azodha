import 'package:flutter/material.dart';
import 'package:todo_impl/impl.dart';
import 'package:todo_ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ToDoDomainDependencyProvider.register();
  ToDoModuleDependencyProvider.register();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Azodha',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const ToDoScreen(),
    );
  }
}
