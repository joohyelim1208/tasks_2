import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';

// '저장'은 2단계로 생각하면 되는데
// 여기서는 사용자가 입력한 텍스트를 newTodo 객체에 담아두는 입력 단계이고, 전달하고 반영하는 단계는 바텀시트가 닫힐 때, 메인리스트인 todoList에 집어넣는 것
// 주문서 작성. 손님이 메뉴를 고르고 요청하는 주문서
class TodoBottmSheet extends StatefulWidget {
  const TodoBottmSheet({super.key});

  @override
  State<TodoBottmSheet> createState() => _TodoBottmSheetState();
}

class _TodoBottmSheetState extends State<TodoBottmSheet> {
  // ! 엔티티클래스를 불러와서 빈 값을 담은 객체를 생성해주기
  final newTodo = TodoEntity(
    title: '',
    description: '',
    isDone: false,
    isFavorite: false,
  );

  // 컨트롤러 정의. 각 필드에서 사용할 것 필요함
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  // 초기값 설정. 리스너추가 글자가 바뀔 때 마다 버튼 상태를 새로고침(setState)하기 위함
  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        newTodo.title = _titleController.text;
      });
    });

    _descController.addListener(() {
      setState(() {
        newTodo.description = _descController.text;
      });
    });
  }

  // 컨트롤러 해제 메모리누수 방지!
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // 부가설명 필드 노출여부 상태값
  bool isDescriptionPop = false;

  @override
  Widget build(BuildContext context) {
    // GestureDetector빈공간 눌렀을 때 키보드 내리는 용도
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.only(
          // 바텀시트가 키보드 위로 올라오도록
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 0),
          child: Column(
            // 안의 내용물 만큼 높이 차지
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              TextField(
                controller: _titleController,
                autofocus: true,
                // 줄바꿈 대신 저장
                textInputAction: TextInputAction.done,
                maxLines: 1,
                // 엔터를 눌렀을 때 저장되는 로직
                onChanged: (value) {
                  setState(() {
                    newTodo.title = value;
                  });
                },
                // title 텍스트필드 부분
                decoration: const InputDecoration(
                  // 밑줄 제거
                  border: InputBorder.none,
                  hintText: '새 할 일',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),

              // 부가설명 아이콘을 눌렀을 때 나타나는 텍스트 필드 로직
              if (isDescriptionPop)
                // 줄이 늘어났을 때 view가 깨지지 않도록 감싸줄 것.(깨지는 현상이 없어서 Expanded를 사용하지는 않았음)
                TextField(
                  controller: _descController,
                  autofocus: true,
                  maxLines: 3,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    // 부가설명을 작성하면 저장을 해줘야
                    setState(() {
                      newTodo.description = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '부가설명',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ),
              Row(
                children: [
                  // 부가설명 아이콘을 누르면 보이지 않는 상태에 대한 로직. ({}를 쓰면 에러남. 다트언어)
                  if (!isDescriptionPop)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDescriptionPop = true;
                        });
                      },
                      child: Icon(Icons.short_text_rounded, size: 24),
                    ),

                  SizedBox(width: 24),
                  // 즐겨찾기 별 아이콘
                  GestureDetector(
                    onTap: () {
                      // 누르면 상태 변경
                      setState(() {
                        newTodo.isFavorite = !newTodo.isFavorite;
                      });
                    },
                    child: Icon(
                      // 삼항연산자 사용
                      newTodo.isFavorite ? Icons.star : Icons.star_border,
                      size: 24,
                      color: newTodo.isFavorite
                          ? Colors.blueAccent
                          : Colors.black54,
                    ),
                  ),
                  Spacer(),

                  // 저장 버튼
                  TextButton(
                    onPressed: () {
                      newTodo.title.trim().isEmpty
                          ? null
                          // 저장이 작동되면 ToDO객체를 반환하고 창닫기
                          : Navigator.pop(context, newTodo);
                      print('${newTodo.title}반환완료');
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                    ),
                    child: Text(
                      '저장',
                      style: TextStyle(
                        // 삼항연산자. 입력요소 따라서 활성화.
                        color: newTodo.title.trim().isEmpty
                            ? Colors.black54
                            : Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
