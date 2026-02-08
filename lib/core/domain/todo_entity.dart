// 설계도. 앱의 핵심 규칙을 정의. 데이터가 어떻게 쓰이는지 바뀌지 않는 값
class TodoEntity {
  // 인스턴스 변수. 각 객체마다 서로 다른 값을 가질 수 있다.
  final String title; // 제목
  final String? description; // 널러블 값을 가지므로 초기화를 안해도 null로 들어감. 부가설명
  final bool isFavorite; // 기본값을 설정해줘야 함. 즐겨찾기
  final bool isDone; // 완료여부

  // 생성자. 인스턴스 변수에 처음 값을 채워넣는 역할
  TodoEntity({
    required this.title, // 생성자. 어떤 값을 가지고 태어날지 결정하는 규칙
    this.description,
    required this.isFavorite, // 기본값 없음: required
    // this.isFavorite = false, // 기본값을 false로 주는 것! (즐겨찾기 상태는 false인 경우가 많아서)
    required this.isDone, // false값을 주거나
  });
}
