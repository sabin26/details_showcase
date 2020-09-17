class PostsList {
  final List<PostModel> posts;

  PostsList({this.posts});

  factory PostsList.fromJson(List<dynamic> json) {
    List<PostModel> posts = json.map((e) => PostModel.fromJson(e)).toList();

    return new PostsList(
      posts: posts,
    );
  }
}

class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"] == null ? null : json["userId"] as int,
        id: json["id"] == null ? null : json["id"] as int,
        title: json["title"] == null ? null : json["title"] as String,
        body: json["body"] == null ? null : json["body"] as String,
      );
}
