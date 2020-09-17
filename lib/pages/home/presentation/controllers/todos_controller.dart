import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum Status { loading, success, error }

class TodosController extends GetxController {
  TodosController({this.todoRepository});

  final ITodoRepository todoRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<TodoModel> todos;

  final UserModel user = Get.find<HomeController>().selectedUser;

  GetStorage box = Get.find<GetStorage>();

  @override
  void onInit() => fetchDataFromApi(user.id);

  Future<void> updateStorage() async {
    String data = jsonEncode(TodosList(todos: todos).toJson());
    await box.remove("todos:${user.id}");
    await box.write("todos:${user.id}", data);
  }

  Future<bool> deleteData(int todoId) async {
    todos.removeWhere((todo) => todo.id == todoId);
    await updateStorage();
    return true;
  }

  Future<void> fetchDataFromApi(int userId) async {
    if (status.value != Status.loading) status(Status.loading);
    return todoRepository.getTodos(userId).then(
      (data) {
        todos = RxList<TodoModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
