import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/page/detail/todo_detail_page.dart';
import 'package:flutter_todo_app/core/widget/todo_appBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const TodoAppbar(),
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          color: Colors.grey[400],
          // 바디영역에 컬럼을 주어야 높이가 생김. 아니면 자식위젯의 높이에 따라가게 됨!
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                // 내부 이미지, 텍스트
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/file.webp',
                      width: 100,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 12),
                    Text(
                      '아직 할 일이 없음',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '할 일을 추가하고 혜림`s Task에서\n할 일을 추적하세요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, size: 24, color: Colors.white),
      ),
    );
  }
}
