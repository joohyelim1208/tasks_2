// TodoEntitiy를 인자로 받는 TodoView위젯 만들기
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/core/domain/todo_entity.dart';

class TodoView extends StatelessWidget {
  const TodoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
  });

  final TodoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
