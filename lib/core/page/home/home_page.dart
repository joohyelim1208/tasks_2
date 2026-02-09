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
  final List<TodoEntity> todoList = [];
  // 즐겨찾기, 부가설명을 새로 추가 할 변수
  bool _isFavorite = false;
  bool _description = false;

  // 입력값 가져오고, 지우고, 수정하는 리모컨 만들기. (_를 붙여서 외부 유출을 막음)
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  // 저장로직 구현
  @override
  void initState() {
    super.initState();
    // 컨트롤러가 변경될 때 마다 .addListener안쪽에 작성한 함수가 호출된다.
    _controller.addListener(() {
      print(_controller.text);
      // 초기데이터 갱신.
      setState(() {
        // 여기서 상태를 업데이트. bool타입의 변수를 만들어서 저장버튼을 눌러도 되는 상황인지, 아닌지(비어있는지 아닌지) 확인
        // 바텀시트를 별도의 스테이트풀위젯으로 분리하고 처리해주기!
      });
    });
  }

  // 페이지가 꺼질 때 리모컨도 파기함. (컨트롤러는 메모리를 계속 잡아먹기 때문에 페이지가 닫힐 때 지워줘야 함)
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _desController.dispose();
  }

  // 내용을 입력하면 저장이 되도록
  void _saveTodo() {
    // 입력값이 비어있을 경우. 공백만 있을 경우에도 작동되지 않도록 구현하기!
    if (_controller.text.trim().isEmpty) return;

    // setState()를 호출해서 화면을 새로고침한다. 1. 데이터 생성
    setState(() {
      // 새로운 할일 추가. 2. 리스트에 추가
      todoList.add(
        TodoEntity(
          title: _controller.text.trim(),
          // 설명창이 열려있을 때에만 내용을 가져오고, 아니면 빈 문자열을 저장함! 삼항연산자 사용하기!
          description: _description ? _desController.text.trim() : '',
          isFavorite: _isFavorite, // 현재 별표시 상태를 저장하기
          isDone: false,
        ),
      );
    });
    // 다음 입력을 위해 필드를 비우기. 3. 입력창을 초기화
    _controller.clear();
    _desController.clear();
    _isFavorite = false;
    _description = false;
    // 저장 후 4. 바텀시트 닫기
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
        shape: CircleBorder(),
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add, color: Colors.white, size: 24),
        onPressed: () {
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 12,
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
                        // 줄바꿈 대신 저장이 되도록 함. 엔터키 누르면 _saveTodo()에 저장이 됨
                        onSubmitted: (_) => _saveTodo(),
                        // 타이틀 부분. 자동 줄바꿈. 일정 줄 수 까지만 늘어나고 그 이후에는 스크롤 됨
                        maxLines: 1,
                        // 타이틀 입력 30글자로 제한
                        maxLength: 30,
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

                      // 부가설명. (아이콘 클릭 시) 텍스트필드 입력창 띄우기 조건은 따로 작성해줌
                      if (_description)
                        // 줄바꿈 시 view가 깨지지 않도록 Expanded로 감싸주기
                        Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: TextField(
                            controller: _desController,
                            autofocus: true,
                            style: TextStyle(fontSize: 14),
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: '세부정보 추가',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      // 아이콘 추가하기
                      Row(
                        children: [
                          // 조건에 따라 아이콘을 보여주어야 하니까. 아이콘에 대한 것만 넣어줌 눌렀을 때 상태변경
                          if (!_description)
                            IconButton(
                              onPressed: () {
                                // 부가설명.
                                setState(() {
                                  // 클릭 시 아이콘 사라지고 필드가 나타나게 함
                                  _description = true;
                                });
                              },
                              icon: Icon(Icons.short_text_rounded, size: 24),
                            ),
                          IconButton(
                            onPressed: () {
                              // 즐겨찾기. 클릭 시 상태반전, 화면 갱신
                              setState(() {
                                // 새 할일 추가 할 때, false일 경우 true로 바꿔주고, true일 경우 false로 바꿔준다.
                                _isFavorite = !_isFavorite;
                              });
                            },
                            // 상태에 따른 아이콘 변경. 삼항연산자를 사용한다.
                            icon: Icon(
                              _isFavorite ? Icons.star : Icons.star_border,
                              size: 24,
                            ),
                          ),

                          Spacer(),

                          TextButton(
                            // 저장함수와 연결.
                            onPressed: _saveTodo,
                            style: TextButton.styleFrom(
                              // 글자색.
                              foregroundColor: Colors.blueAccent,
                              // 터치할 수 있는 범위를 지정
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text('저장'),
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
      ),
    );
  }
}
