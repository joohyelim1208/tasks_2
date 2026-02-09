import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';
import 'package:flutter_todo_app/core/widget/todo_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 값이 담길 엔티티 리스트 리스트 관리 변수 추가하기.
  List<TodoEntity> TodoList = [];

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
        onPressed: () {
          showModalBottomSheet(
            context: context,
            // 키보드와 함께 바텀시트가 위로 올라옴
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                // 키보드 높이 만큼 바텀시트에 패딩 추가하기
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                  bottom: 0,
                ),

                child: Column(
                  // 전체화면을 차지하지 않고 텍스트 내용 만큼만 크기 설정하기. 자식위젯들이 차지하는 공간만큼 줄이라는 뜻
                  mainAxisSize: MainAxisSize.min,
                  // 텍스트필드 넣기
                  children: [
                    TextField(
                      // 텍스트필드에 포커스가 잡히도록
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: '새 할 일',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            //
          );
        },
        shape: CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
