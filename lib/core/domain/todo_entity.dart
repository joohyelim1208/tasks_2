class TodoEntity {
  // 수정이 가능하도록 final제거
  String title;
  String? description; // 부가설명
  bool isFavorite;
  bool isDone;

  TodoEntity({
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
  });
}
