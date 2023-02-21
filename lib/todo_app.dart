import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/screens/sign_up_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return const MaterialApp(
        title: 'Todo App',
        home: SignUpScreen(),
      );
    });
  }
}
