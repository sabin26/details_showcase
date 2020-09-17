import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/posts_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/expanded_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostsView extends GetWidget<PostsController> {
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
              softWrap: true,
              maxLines: 2,
            ),
          );
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            PostModel post = controller.posts[index];
            return ExpandedWidget(
              title: post.title,
              body: bodyWidget(post),
            );
          },
        );
      }),
    );
  }

  Widget bodyWidget(PostModel post) {
    return Column(
      children: <Widget>[
        Text(post.body, softWrap: true),
        OutlineButton(
          highlightColor: Colors.grey[300],
          splashColor: Colors.grey[200],
          onPressed: () {
            controller.setPost(post);
            Get.toNamed("/comments").then((value) {
              controller.resetPost();
            });
          },
          child: Center(
            child: Text(
              "View Comments",
              style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
            ),
          ),
        )
      ],
    );
  }
}
