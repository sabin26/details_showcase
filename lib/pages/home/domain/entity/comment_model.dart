class CommentsList {
  final List<CommentModel> comments;

  CommentsList({this.comments});

  factory CommentsList.fromJson(List<dynamic> json) {
    List<CommentModel> comments =
        json.map((e) => CommentModel.fromJson(e)).toList();

    return new CommentsList(
      comments: comments,
    );
  }
}

class CommentModel {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  CommentModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        postId: json["postId"] == null ? null : json["postId"] as int,
        id: json["id"] == null ? null : json["id"] as int,
        name: json["name"] == null ? null : json["name"] as String,
        email: json["email"] == null ? null : json["email"] as String,
        body: json["body"] == null ? null : json["body"] as String,
      );
}
