import 'package:flutter/material.dart';

// 셋스테이트로 저장버튼 활성화되도록
// UI부분은 스테이트풀 위젯이고 메서드 기능구현은 별도로
class TodoBottomsheet {
  // 클래스를 인스턴스객체에 담을 필요 없이 바로 호출하는 스태틱 메서드
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      //
      isScrollControlled: true,
      builder: (BuildContext context) {
        // UI 위젯 호출하고 기능 클래스 메서드를 콜백으로 연결하기
        return Padding(
          padding: EdgeInsets.only(
            // 바텀시트가 키보드 위로 올라오도록
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 0),
            height: 100,
            child: Column(
              children: [
                //
                TextField(
                  autofocus: true,
                  // 줄바꿈 대신 저장
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  // 엔터를 눌렀을 때 저장되는 로직
                  onSubmitted: (value) {
                    // 텍스트가 비어있을 땐 저장이 되지 않도록 구현
                    if (value.trim().isEmpty) {
                      print('할 일을 입력해주세요.');
                      return;
                    }
                    saveToDo();
                    print('새 할 일이 저장되었습니다.');
                  },

                  decoration: InputDecoration(
                    // 밑줄 제거
                    border: InputBorder.none,
                    hintText: '새 할 일',
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class saveToDo {}
