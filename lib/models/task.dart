class Task {
  int? id; // タスクのID (データベースのプライマリキー)
  String name; // タスクの名前
  bool isDone; // タスクが完了したかどうか
  String createdAt; //Taskの作成日

  Task({
    this.id,
    required this.name,
    this.isDone = false,
    required this.createdAt,
  });

  // データベースから読み込むためのファクトリメソッド
  factory Task.fromMap(Map<String, dynamic> data) => Task(
        id: data['id'],
        name: data['name'],
        isDone: data['isDone'] == 1,
        createdAt: data['createdAt'],
      );

  // データベースに保存するためのデータをマップ形式で提供
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone ? 1 : 0,
      'createdAt': createdAt,
    };
  }

  // タスクの完了状態をトグル
  void toggleDone() {
    isDone = !isDone;
  }
}
