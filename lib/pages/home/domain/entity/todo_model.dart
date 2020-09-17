class TodosList {
  final List<TodoModel> todos;

  TodosList({this.todos});

  factory TodosList.fromJson(List<dynamic> json) {
    List<TodoModel> todos = json.map((e) => TodoModel.fromJson(e)).toList();

    return new TodosList(
      todos: todos,
    );
  }

  List<dynamic> toJson() =>
      List<dynamic>.from(todos.map((todo) => todo.toJson()));
}

class TodoModel {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"] == null ? null : json["userId"] as int,
        id: json["id"] == null ? null : json["id"] as int,
        title: json["title"] == null ? null : json["title"] as String,
        completed: json["completed"] == null ? null : json["completed"] as bool,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "completed": completed == null ? null : completed,
      };
}
