import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';
import 'package:flutter_todo_app/core/page/detail/todo_detail_page.dart';

// 음식접시. 주방에서 만든 음식을 담아 손님에게 내놓는 그릇.
// TodoEntity를 인자로 받음
// todo 한개만 보여주는 위젯. 투두 엔티티 한개만 받아서는 그릴 수 없음
class TodoView extends StatefulWidget {
  // 생성자를 통해서 데이터를 받는 역할
  const TodoView({
    super.key,
    required this.index,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
    required this.onUpdate,
  });
  // 데이터를 저장할 변수
  final TodoEntity toDo;
  final int index;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;
  // 즐겨찾기 업데이트 신호를 보낼 바구니 추가함
  final VoidCallback onUpdate;

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    // 그릇 1개
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        child: ListTile(
          // 리스트 타일 안에서 글자 간 간격조정
          horizontalTitleGap: 20,
          leading: GestureDetector(
            onTap: () {
              // 부모인 홈페이지에서 클릭 시 넘겨준 값을 받는것
              // 여기서 setState를 쓰는게 아니라 부모인 홈페이지에서 상태가 변경되면 반영하는 것
              widget.onToggleDone();
            },
            child: Icon(
              // 데이터의 상태에 따라 아이콘이 변경되는 부분. 삼항연산자
              widget.toDo.isDone ? Icons.check_circle : Icons.circle_outlined,
              size: 24,
              color: widget.toDo.isDone ? Colors.blueAccent : Colors.black54,
            ),
          ),
          // 실제 데이터를 연결하기
          title: Text(
            // 리스트의 개수가 늘 수록 할 일 뒤에 숫자 카운트의 변화가 있도록 한다면?
            // 인덱스 값을 주고 싶으면 변수와 생성자를 만들어 준 뒤, 홈페이지에서도 인덱스를 추가해서 수정해주어야 함!!
            '${widget.index + 1} ${widget.toDo.title}',
            // Done 상태에 따라서 타이틀에 취소선 상태를 적용시키기
            style: TextStyle(
              decoration: widget.toDo.isDone
                  ? TextDecoration.lineThrough
                  : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: () {
              widget.onToggleFavorite();
            },
            child: Icon(
              widget.toDo.isFavorite ? Icons.star : Icons.star_border,
              size: 24,
              color: widget.toDo.isFavorite
                  ? Colors.blueAccent
                  : Colors.black54,
            ),
          ),
          // '전체'를 눌렀을 때 상세페이지 이동
          onTap: () async {
            await Navigator.of(context).push<TodoEntity>(
              MaterialPageRoute(
                // 디테일페이지로 이동하면서 현재 위젯이 가지고 있는 toDo 데이터를 넘겨줌. Navigator.push
                builder: (context) =>
                    TodoDetailPage(toDo: widget.toDo, index: widget.index),
              ),
            );
            // 바구니가 있든 없든 상세페이지에 갔다왔으면 무조건 홈 화면 새로고침 신호보내기
            // 홈페이지 가서 온업데이트 함수 넣어주기
            widget.onUpdate();
          },
        ),
      ),
    );
  }
}
