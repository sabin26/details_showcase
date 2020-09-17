import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todo_dialog_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todos_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/button.dart';
import 'package:details_showcase/pages/home/presentation/widgets/expanded_panel.dart';
import 'package:details_showcase/pages/home/presentation/widgets/todo_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoView extends GetWidget<TodosController> {
  @override
  Widget build(BuildContext context) {
    final UserModel user = controller.user;
    return Center(
      child: Obx(() {
        Status status = controller.status.value;
        if (status == Status.loading) return CircularProgressIndicator();
        if (status == Status.error)
          return GestureDetector(
            onTap: () {
              controller.fetchDataFromApi(user.id);
            },
            child: Text(
              "Error on connection :(\nTap to retry",
              maxLines: 2,
              softWrap: true,
            ),
          );
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            TodoModel todo = controller.todos[index];
            return ExpandedWidget(
              title: todo.title,
              body: bodyWidget(todo),
            );
          },
        );
      }),
    );
  }

  Widget bodyWidget(TodoModel todo) {
    return Column(
      children: <Widget>[
        Text("Completed: " + todo.completed.toString(), softWrap: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              buttonTitle: "Update",
              onPressed: () {
                Get.find<TodoDialogController>().setTextValue(todo.title);
                Get.dialog(
                  TodoDialogContent(
                    height: 190,
                    isUpdate: true,
                    todo: todo,
                  ),
                );
              },
            ),
            Button(
              buttonTitle: "Delete",
              onPressed: () async {
                await controller.deleteData(todo.id);
                Get.snackbar("Success", "The todo is now deleted");
              },
            ),
          ],
        ),
      ],
    );
  }
}
