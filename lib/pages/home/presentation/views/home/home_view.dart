import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Details Showcase"),
      ),
      body: Center(
        child: Obx(() {
          Status status = controller.status.value;
          if (status == Status.loading) return CircularProgressIndicator();
          if (status == Status.error)
            return GestureDetector(
              onTap: () {
                controller.fetchDataFromApi();
              },
              child: Text(
                "Error on connection :(\nTap to retry",
                maxLines: 2,
                softWrap: true,
              ),
            );
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              UserModel user = controller.users[index];
              return ListTile(
                onTap: () {
                  controller.setUser(user);
                  Get.toNamed("/data").then((value) {
                    controller.resetUser();
                  });
                },
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(user.name),
                subtitle: Text("User Id: ${user.id}"),
              );
            },
          );
        }),
      ),
    );
  }
}
