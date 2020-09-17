import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TodoRepository implements ITodoRepository {
  TodoRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<TodoModel>> getTodos(int userId) async {
    if (box.read("todos:$userId") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/users/$userId/todos",
          headers: {"content-type": "application/json"},
        );
        await box.write("todos:$userId", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parseTodos, box.read<String>("todos:$userId"));
  }
}

List<TodoModel> parseTodos(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  TodosList todosList = TodosList.fromJson(data);
  return todosList.todos;
}
