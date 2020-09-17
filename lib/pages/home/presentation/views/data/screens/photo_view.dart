import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:details_showcase/pages/home/domain/entity/photo_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/photos_controller.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotosGridView extends GetWidget<PhotosController> {
  @override
  Widget build(BuildContext context) {
    final AlbumModel album = controller.album;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(closeOverlays: true);
          },
        ),
        centerTitle: true,
        title: Text("Photos"),
      ),
      body: Center(
        child: Obx(() {
          Status status = controller.status.value;
          if (status == Status.loading) return CircularProgressIndicator();
          if (status == Status.error)
            return GestureDetector(
              onTap: () {
                controller.fetchDataFromApi(album.id);
              },
              child: Text(
                "Error on connection :(\nTap to retry",
                maxLines: 2,
                softWrap: true,
              ),
            );
          return GridView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: controller.photos.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              PhotoModel photo = controller.photos[index];
              return GridTile(
                child: PhotoView(
                  photo: photo,
                  onTap: () {
                    Get.dialog(DialogContent(photo: photo));
                  },
                  isThumbnail: true,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  final PhotoModel photo;
  final void Function() onTap;
  final bool isThumbnail;
  PhotoView({this.photo, this.onTap, this.isThumbnail});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ExtendedImage.network(
        isThumbnail ? photo.thumbnailUrl : photo.url,
        cache: true,
      ),
    );
  }
}

class DialogContent extends GetWidget {
  final PhotoModel photo;
  DialogContent({this.photo});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: Get.width,
          height: Get.width,
          child: Material(
            child: PhotoView(
              photo: photo,
              onTap: () {},
              isThumbnail: false,
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: Text(
            photo.title,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 5,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
