import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TodoDialogController extends GetxController {
  TextEditingController textController = TextEditingController();

  TodosController todosController = Get.find();

  bool isCompleted;

  final UserModel user = Get.find<HomeController>().selectedUser;

  GetStorage box = Get.find<GetStorage>();

  @override
  void onClose() => textController.dispose();

  void setTextValue(String text) {
    textController.text = text;
  }

  Future<bool> addData() async {
    if (textController.value.text.isNotEmpty) {
      todosController.todos.add(
        TodoModel(
            userId: user.id,
            id: todosController.todos.last.id + 1,
            title: textController.value.text,
            completed: false),
      );
      await todosController.updateStorage();
      return true;
    }
    return false;
  }

  Future<bool> updateData(int todoId) async {
    TodoModel todo =
        todosController.todos.singleWhere((todo) => todo.id == todoId);
    String title = textController.value.text;
    if (todo.title.compareTo(title) != 0 || todo.completed != isCompleted) {
      int index = todosController.todos.indexOf(todo);
      todosController.todos.replaceRange(index, index + 1, [
        TodoModel(
            userId: todo.userId,
            id: todo.id,
            title: title,
            completed: isCompleted)
      ]);
      await todosController.updateStorage();
      return true;
    }
    return false;
  }
}
