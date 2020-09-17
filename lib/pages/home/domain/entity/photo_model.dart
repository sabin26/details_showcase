class PhotosList {
  final List<PhotoModel> photos;

  PhotosList({this.photos});

  factory PhotosList.fromJson(List<dynamic> json) {
    List<PhotoModel> photos = json.map((e) => PhotoModel.fromJson(e)).toList();

    return new PhotosList(
      photos: photos,
    );
  }
}

class PhotoModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  PhotoModel({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        albumId: json["albumId"] == null ? null : json["albumId"] as int,
        id: json["id"] == null ? null : json["id"] as int,
        title: json["title"] == null ? null : json["title"] as String,
        url: json["url"] == null ? null : json["url"] as String,
        thumbnailUrl: json["thumbnailUrl"] == null
            ? null
            : json["thumbnailUrl"] as String,
      );
}
