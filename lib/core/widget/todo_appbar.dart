import 'package:flutter/material.dart';

// 높이 지정
class TodoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      // 그림자 제거
      elevation: 0,
      title: Text(
        '혜림`s Tasks',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
