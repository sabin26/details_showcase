import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/albums_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/expanded_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumsView extends GetWidget<AlbumsController> {
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
          itemCount: controller.albums.length,
          itemBuilder: (context, index) {
            AlbumModel album = controller.albums[index];
            return ExpandedWidget(
              title: album.title,
              body: OutlineButton(
                highlightColor: Colors.grey[300],
                splashColor: Colors.grey[200],
                onPressed: () {
                  controller.setAlbum(album);
                  Get.toNamed("/photos").then((value) {
                    controller.resetAlbum();
                  });
                },
                child: Center(
                  child: Text(
                    "View photos",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
