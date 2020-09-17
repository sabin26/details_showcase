class AlbumsList {
  final List<AlbumModel> albums;

  AlbumsList({this.albums});

  factory AlbumsList.fromJson(List<dynamic> json) {
    List<AlbumModel> albums = json.map((e) => AlbumModel.fromJson(e)).toList();

    return new AlbumsList(
      albums: albums,
    );
  }
}

class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    this.userId,
    this.id,
    this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) => AlbumModel(
        userId: json["userId"] == null ? null : json["userId"] as int,
        id: json["id"] == null ? null : json["id"] as int,
        title: json["title"] == null ? null : json["title"] as String,
      );
}
