import 'package:details_showcase/pages/home/presentation/controllers/screen_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todo_dialog_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todos_controller.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/albums_view.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/posts_view.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/todo_view.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/user_details_view.dart';
import 'package:details_showcase/pages/home/presentation/widgets/todo_dialog_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DataView extends GetView<ScreenController> {
  final List<String> titles = [
    "Posts",
    "Albums",
    "Todo",
    "Details",
  ];
  final List<Widget> widgets = [
    PostsView(),
    AlbumsView(),
    TodoView(),
    UserDetailsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back(closeOverlays: true);
          },
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(titles[controller.page.value]);
        }),
        actions: <Widget>[
          Obx(() {
            if (controller.page.value == 2)
              return FlatButton.icon(
                highlightColor: Colors.grey[300],
                splashColor: Colors.grey[200],
                icon: Icon(Icons.add),
                label: Text('New'),
                onPressed: () {
                  if (Get.isRegistered<TodosController>()) {
                    Get.find<TodoDialogController>().setTextValue("");
                    Get.dialog(
                      TodoDialogContent(
                        height: 150,
                        isUpdate: false,
                      ),
                    );
                  } else {
                    Get.snackbar(
                        "Info", "Click only when data is fully loaded");
                  }
                },
              );
            return SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        return widgets[controller.page.value];
      }),
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.photo_library, size: 30),
          Icon(Icons.description, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.brown[50],
        backgroundColor: Colors.blue[200],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 250),
        onTap: (index) {
          controller.updateValue(index);
        },
      ),
    );
  }
}
