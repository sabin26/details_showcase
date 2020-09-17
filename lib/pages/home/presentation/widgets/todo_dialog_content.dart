import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todo_dialog_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoDialogContent extends GetWidget<TodoDialogController> {
  final double height;
  final bool isUpdate;
  final TodoModel todo;
  TodoDialogContent({this.height, this.isUpdate, this.todo});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: Get.width - 50,
        height: height,
        child: Material(
          elevation: 24.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          type: MaterialType.card,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  textInputAction: TextInputAction.done,
                  controller: controller.textController,
                  minLines: 1,
                  maxLines: 1,
                  maxLength: 80,
                  decoration: InputDecoration(labelText: 'Title'),
                  buildCounter: (BuildContext context,
                          {int currentLength, int maxLength, bool isFocused}) =>
                      null,
                ),
                if (isUpdate)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(child: Text("Completed:")),
                      Flexible(
                        child: ValueBuilder<bool>(
                          initialValue: todo.completed,
                          builder: (value, updateFn) {
                            controller.isCompleted = value;
                            return Switch(
                              value: value,
                              onChanged: updateFn,
                            );
                          },
                          onUpdate: (value) => controller.isCompleted = value,
                        ),
                      ),
                    ],
                  ),
                Button(
                  buttonTitle: isUpdate ? "Save" : "Add",
                  onPressed: () async {
                    Get.back();
                    bool success = isUpdate
                        ? await controller.updateData(todo.id)
                        : await controller.addData();
                    if (success) {
                      return Get.snackbar(
                        "Success",
                        isUpdate
                            ? "Todo is now updated"
                            : "New todo is now added",
                      );
                    }
                    return Get.snackbar(
                      "Failed",
                      isUpdate
                          ? "No changes detected"
                          : "Please insert valid data",
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
