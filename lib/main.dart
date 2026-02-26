import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/page/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          // 스캐폴드 영역 바깥 전체적인 배경색
          surface: Colors.grey[200],
        ),
      ),
      home: HomePage(),
    );
  }
}
