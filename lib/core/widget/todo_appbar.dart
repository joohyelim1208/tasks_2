import 'package:flutter/material.dart';

// 앱 바의 높이 지정을 하려면 preferrendSize위젯으로 앱바를 감싸고 속성을 설정
class TodoAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "혜림`s Tasks",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      //
    );
  }

  @override
  // getter 변수처럼 호출해도 값을 가져올 수 있게 해주는 문법. => : return {}
  // 너비는 화면에 채우고 높이는 고정된 Size객체. kToolbarHeight: 기종 상관없이 가장 표준적인 높이값
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
