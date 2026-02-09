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
  final List<TodoEntity> TodoList = [];

  // 입력값 가져오고, 지우고, 수정하는 리모컨 만들기. (_를 붙여서 외부 유출을 막음)
  final TextEditingController _controller = TextEditingController();

  // 페이지가 꺼질 때 리모컨도 파기함. (컨트롤러는 메모리를 계속 잡아먹기 때문에 페이지가 닫힐 때 지워줘야 함)
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 내용을 입력하면 저장이 되도록
  void _saveTodo() {
    // 입력값이 비어있을 경우. 공백만 있을 경우에도 작동되지 않도록 구현하기!
    if (_controller.text.trim().isEmpty) return;

    // setState()를 호출해서 화면을 새로고침한다.
    setState(() {
      // 새로운 할일 추가
      TodoList.add(
        TodoEntity(
          title: _controller.text.trim(),
          description: _controller.text.trim(),
          isFavorite: false,
          isDone: false,
        ),
      );
    });
    // 다음 입력을 위해 필드를 비우기
    _controller.clear();
    // 저장 후 바텀시트 닫기
    Navigator.pop(context);
    print('할 일이 저장되었습니다.');
  }

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
          // 텍스트창을 한번 더 초기화해줌
          _controller.clear();
          showModalBottomSheet(
            context: context,
            // 키보드와 함께 바텀시트가 위로 올라옴
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                // 키보드 높이 만큼 바텀시트에 패딩 추가하기
                // 싱글차일드스크롤 뷰 밖에 패딩이 있는게 나음. 스크롤 할 때 여백까지 같이 밀려올라가거나 의도와 다르게 동작 가능해서
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 12,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                // 단일자식 위젯에 스크롤 기능 추가하는 컨테이너 위젯. 오버플로우 방지
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    // 전체화면을 차지하지 않고 텍스트 내용 만큼만 크기 설정하기. 자식위젯들이 차지하는 공간만큼 줄이라는 뜻
                    mainAxisSize: MainAxisSize.min,
                    // 텍스트필드 넣기
                    children: [
                      TextField(
                        // 리모컨 추가함
                        controller: _controller,
                        // 줄바꿈 대신 저장이 되도록 함. 엔터키 누르면 저장이 됨
                        onSubmitted: (_) => _saveTodo(),
                        // 자동 줄바꿈. 일정 줄 수 까지만 늘어나고 그 이후에는 스크롤 됨
                        minLines: 1,
                        maxLines: 3,
                        // 텍스트필드에 포커스가 잡히도록
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: '새 할 일',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          // 텍스트 필드 하단 밑줄 없앰
                          border: InputBorder.none,
                        ),
                      ),
                      // 아이콘 추가하기
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // 부가설명
                              setState(() {
                                //
                              });
                            },
                            icon: Icon(Icons.short_text_rounded, size: 24),
                          ),
                          IconButton(
                            onPressed: () {
                              // 즐겨찾기. 클릭 시 상태반전, 화면 갱신
                              setState(() {
                                // 투두리스트에 있는 description의 상태를 변경한다.
                              });
                            },
                            // 상태에 따른 아이콘 변경. 삼항연산자를 사용한다.
                            icon: Icon(Icons.star_border, size: 24),
                          ),
                          Text(
                            '저장',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
