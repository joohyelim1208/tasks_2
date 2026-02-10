import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';

// 1. 클래스 생성. 홈페이지에서 작성한 showModalBottomSheet코드 스테이트풀위젯으로 파일분리
class TodoSheet extends StatefulWidget {
  // 2. 저장버튼을 눌렀을 때 부모에게 엔티티 리스트 전달할 관리 콜백 함수를 정의하기. 변수생성
  // 인자로 투두엔티티를 넘겨받을 수 있게 해줘야 함. VoidCallback 은 반환값이 없는 함수
  final Function(TodoEntity) onSaved;

  // 3. 생성자 초기화. 콜백을 전달받음
  const TodoSheet({super.key, required this.onSaved});

  @override
  State<TodoSheet> createState() => _TodoSheetState();
}

class _TodoSheetState extends State<TodoSheet> {
  // 4. 바텀시트에서 사용하는 독립적인 상태들 가지고 오기

  // 즐겨찾기, 부가설명을 새로 추가 할 변수
  bool _isFavorite = false;
  bool _description = false;
  bool _isButtonSave = false;

  // 입력값 가져오고, 지우고, 수정하는 리모컨 만들기. (_를 붙여서 외부 유출을 막음)
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _desController = TextEditingController();

  // 저장로직 구현
  @override
  // 1. 초기화 코드
  void initState() {
    super.initState();
    // 컨트롤러가 변경될 때 마다 제목입력감지 리스너인 addListener안쪽에 작성한 함수가 호출된다.
    _controller.addListener(() {
      // 텍스트가 비어있지 않으면 true, 비어있으면 false. 저장버튼 활성화에 쓰일 부분
      bool isNotEmpty = _controller.text.trim().isNotEmpty;
      // print(_controller.text);
      // 초기데이터 갱신. 상태가 바뀔 때만 setState를 호출. 저장버튼을 눌러도 될지, 아닌지(비어있는지) 확인
      if (isNotEmpty != _isButtonSave) {
        setState(() {
          _isButtonSave = isNotEmpty;
        });
      }
    });
  }

  // 페이지가 꺼질 때 리모컨도 파기함. (컨트롤러는 메모리를 계속 잡아먹기 때문에 페이지가 닫힐 때 지워줘야 함)
  @override
  // 정리 코드
  void dispose() {
    super.dispose();
    _controller.dispose();
    _desController.dispose();
  }

  // 내용을 입력하면 저장이 되도록. 1. setState호출되면 상태 업데이트 2. build메서드 다시 재실행 3. 위젯트리가 재구성되고 UI 업데이트
  void _saveTodo() {
    // 입력값이 비어있을 경우. 공백만 있을 경우에도 작동되지 않도록 구현하기!
    if (_controller.text.trim().isEmpty) return;

    // setState()를 호출해서 화면을 새로고침한다. 1. 데이터 생성
    // setState(() {
    //   // 새로운 할일 추가. 2. 리스트에 추가
    //   todoList.add(
    //     TodoEntity(
    //       title: _controller.text.trim(),
    //       // 설명창이 열려있을 때에만 내용을 가져오고, 아니면 빈 문자열을 저장함! 삼항연산자 사용하기!
    //       description: _description ? _desController.text.trim() : '',
    //       isFavorite: _isFavorite, // 현재 별표시 상태를 저장하기
    //       isDone: false,
    //     ),
    //   );
    // });

    // 새로 자식에 엔티티 생성하기!(Usage). 부모에서 입력을 받은 값이 투두리스트에 저장되는 것. 변수에 담겼으니 부모에게로 전달해야 하는데???
    final todoEntitySheet = TodoEntity(
      title: _controller.text.trim(),
      description: _description ? _desController.text.trim() : '',
      isFavorite: _isFavorite,
      isDone: false,
    );

    // 자식이 부모에게 데이터를 전달하는 것을 콜백이라 함!!!
    widget.onSaved(todoEntitySheet);

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
    // 5. showModalBottomSheet에서 작성한 코드 가지고 오기. builder 안 작성
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
              // 줄바꿈 대신 저장이 되도록 완료 버튼기능. 엔터키 누르면 _saveTodo()에 저장이 되는건 Navirator.pop코드가 있어야 함.
              onSubmitted: (_) => _saveTodo(),
              // 타이틀 부분. 자동 줄바꿈. 일정 줄 수 까지만 늘어나고 그 이후에는 스크롤 됨
              maxLines: 1,
              // 타이틀 입력 30글자로 제한
              maxLength: 30,
              // 텍스트필드에 포커스가 잡히도록
              autofocus: true,
              decoration: InputDecoration(
                hintText: '새 할 일',
                hintStyle: TextStyle(fontSize: 16, color: Colors.black54),
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
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
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
                  onPressed: _isButtonSave ? _saveTodo : null,
                  style: TextButton.styleFrom(
                    // 글자색. 상태에 따라 활성화 되게 하기
                    foregroundColor: _isButtonSave
                        ? Colors.blueAccent
                        : Colors.black54,
                    // 터치할 수 있는 범위를 지정
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: TextStyle(
                      fontSize: 16,
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
  }
}
