import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';

import 'package:flutter_todo_app/core/widget/todo_appBar.dart';

class TodoDetailPage extends StatefulWidget {
  // 데이터를 받을 준비를 해야된다. TodoEntity를 받아서 화면 컨텐츠 채우기
  final TodoEntity toDo;
  final int index;
  const TodoDetailPage({super.key, required this.toDo, required this.index});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TodoAppbar(
        title: '',
        // 뒤로가기 구현
        // 뒤로가기 버튼을 누를 때 수정된 isFavorite을 담고 나감
        showBack: true,
        // 투두뷰에서 추가한 보이드콜백 함수 사용. 그냥 되돌아가는게 아니라 내가 바꾼 데이터를 들고 나감!
        onBackPressed: () {
          Navigator.pop(context, widget.toDo);
        },
        actions: [
          IconButton(
            onPressed: () {
              // 즐겨찾기를 누르면 아이콘의 상태가 변화하고, 현재페이지 뒤로간 페이지 모두 반영되어야 함!
              setState(() {
                // 바로 상태가 변경될 수 있도록 구현
                widget.toDo.isFavorite = !widget.toDo.isFavorite;
              });
            },
            icon: Icon(
              widget.toDo.isFavorite ? Icons.star : Icons.star_border,
              size: 24,
              color: widget.toDo.isFavorite
                  ? Colors.blueAccent
                  : Colors.black54,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // 컬럼 세로축 좌측, 로우 위 가운데 정렬
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 새로운 할 일 뒤에 리스트 목록의 번호 순 대로 출력.
              // 인덱스를 받을 변수와 생성자를 추가
              Text('새로운 할 일 ${widget.index + 1}'),
              // 타이틀, 세부내용을 입력한 리스트가 똑같이 출력이 되면 된다.
              Text(
                widget.toDo.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Icon(Icons.short_text_rounded),
                  SizedBox(width: 12),
                  Text('세부내용은 다음과 같습니다.', style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 20),
              Text(
                // 만약 비어있으면 null값으로 취급
                (widget.toDo.description ?? '').isEmpty
                    ? '내용이 없습니다.'
                    : widget.toDo.description!,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
