import 'package:details_showcase/pages/home/domain/entity/comment_model.dart';
import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/comments_controller.dart';
import 'package:details_showcase/pages/home/presentation/widgets/expanded_panel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsView extends GetWidget<CommentsController> {
  @override
  Widget build(BuildContext context) {
    final PostModel post = controller.post;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
          centerTitle: true,
          title: Text("Comments"),
        ),
        body: Center(
          child: Obx(() {
            Status status = controller.status.value;
            if (status == Status.loading) return CircularProgressIndicator();
            if (status == Status.error)
              return GestureDetector(
                onTap: () {
                  controller.fetchDataFromApi(post.id);
                },
                child: Text(
                  "Error on connection :(\nTap to retry",
                  maxLines: 2,
                  softWrap: true,
                ),
              );
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: controller.comments.length,
              itemBuilder: (context, index) {
                CommentModel comment = controller.comments[index];
                return ExpandedWidget(
                  title: comment.name,
                  body: bodyWidget(comment.body, comment.email),
                );
              },
            );
          }),
        ));
  }

  Widget bodyWidget(String body, String email) {
    return Column(
      children: <Widget>[
        Text(body, softWrap: true),
        Center(
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Text(
              email,
              style: TextStyle(color: Colors.lightBlue, fontSize: 15.0),
            ),
          ),
        )
      ],
    );
  }
}
