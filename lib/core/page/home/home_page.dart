import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';
import 'package:flutter_todo_app/core/page/home/widget/todo_sheet.dart';
import 'package:flutter_todo_app/core/widget/todo_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TodoEntity> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppbar(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset('assets/images/file.webp'),

                  // 이미지가 없을 경우
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
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, color: Colors.white, size: 24),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            // 키보드와 함께 바텀시트가 위로 올라옴
            isScrollControlled: true,
            builder: (context) {
              // 분리된 바텀시트 위젯을 호출한다. 자식이 던져준 데이터를 받아서 리스트에 추가하기
              return TodoSheet(
                // 온세이브드 함수에서 넘겨받아야 됨!!
                onSaved: (TodoEntity todoEntitySheet) {
                  setState(() {
                    // 작성 시 자식의 데이터를 받아서 투두리스트에 추가됨
                    todoList.add(todoEntitySheet);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
