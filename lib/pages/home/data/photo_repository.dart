import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/photo_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PhotoRepository implements IPhotoRepository {
  PhotoRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<PhotoModel>> getPhotos(int albumId) async {
    if (box.read("photos:$albumId") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/albums/$albumId/photos",
          headers: {"content-type": "application/json"},
        );
        await box.write("photos:$albumId", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parsePhotos, box.read<String>("photos:$albumId"));
  }
}

List<PhotoModel> parsePhotos(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  PhotosList photosList = PhotosList.fromJson(data);
  return photosList.photos;
}
