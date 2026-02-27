import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';
import 'package:flutter_todo_app/core/page/home/todo_bottom_Sheet.dart';
import 'package:flutter_todo_app/core/page/home/widget/todo_view.dart';
import 'package:flutter_todo_app/core/widget/todo_appBar.dart';

// 식당 홀. 손님이 앉는 테이블과 메뉴판(앱 바)가 있는 곳. 전체적인 판을 짬
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 데이터창고 선언. 데이터를 담을 리스트가 있어야 비어있는지 물어볼 수 있음.
  List<TodoEntity> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 화면에 키보드가 나타날 때 화면 크기를 줄여 키보드 위로 올릴지 결정하는 역할. 로그인화면에서는 true로 자동 크기조절 하는게 좋다.
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      appBar: const TodoAppbar(),
      body: SafeArea(
        bottom: false,
        // 1. 삼항연산자 사용. 리스트가 비었으면 빈 화면을 보여주고 아니면 2. 리스트뷰 빌더를 사용해서 투두뷰 보여줌
        // 데이터가 있는지 먼저 물어본 다음 결과에 따라스 리스트뷰를 그려줄지 아닐지 결정되는 구조임
        child: todoList.isEmpty
            ? Container(
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
              )
            // 리스트뷰는 익스펜디드로 감싸주어야 높이 충돌이 일어나지 않음
            : Container(
                color: Colors.grey[400],
                child: ListView.builder(
                  // 리스트가 있을 경우 리스트의 길이만큼 호출
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    // 리스트에서 아이템을 하나씩 꺼내서 보여줘야 함
                    final item = todoList[index];
                    // TodoView위젯에 아이템을 넣어서 돌려준다.
                    return TodoView(
                      toDo: item,
                      // 지금 당장 실행하지 않고 나중에 버튼이 눌렸을 때 실행할 동작이 담길 주머니를 만들어 준것
                      // 익명함수-메모지. () 입구: 동작 시 필요한 재료. {}: 주머니: 이 안에 있는 코드를 실행해줘. 동작의 범위
                      index: index,
                      onToggleFavorite: () {
                        // 즐겨찾기 로직 넣으면 됨. 클릭 시 상태 반전
                        setState(() {
                          item.isFavorite = !item.isFavorite;
                        });
                        print('${item.title} 즐겨찾기');
                      },
                      onToggleDone: () {
                        // 완료 로직 넣으면 됨
                        setState(() {
                          item.isDone = !item.isDone;
                        });
                        print('${item.title} 완료');
                      },
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 바텀시트는 사용자가 저장을 누를 때 까지 기다려야 한다. 그래서 await를 쓰고 결과물 TodoEntity를 result라는 변수에 담는 것
          // 쇼모달바텀시트에 제네릭 함수를 사용할 것!!!!
          // 호출 시 타입을 결정하여 코드의 재사용성과 타입안정성을 높이는 기능 void function<T> (T value)
          final result = await showModalBottomSheet<TodoEntity?>(
            context: context,
            isScrollControlled: true,
            // 빌더는 화면을 그릴 때 사용함. 입력이 끝난 뒤에야 리스트에 추가를 할 수 있음
            builder: (BuildContext context) {
              // 바텀시트에서는 입력값이 저장되어 있는거고, 홈페이지에서는 이 newTodo 데이터를 메인 리스트에 집어넣는 일을 한다.
              // (손님이 주문서를 다 썼는데 전달하지 않고 테이블 위에 그대로 둔 상태)
              return TodoBottmSheet();
            },
          );
          // 반환값이 있을 경우 리스트에 추가해준다!
          if (result != null) {
            // 데이터가 변할 때 화면을 다시 그린다.
            setState(() {
              todoList.add(result);
            });
          }
        },
        shape: CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, size: 24, color: Colors.white),
      ),
    );
  }
}
