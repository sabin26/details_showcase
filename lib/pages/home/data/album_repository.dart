import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AlbumRepository implements IAlbumRepository {
  AlbumRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<AlbumModel>> getAlbums(int userId) async {
    if (box.read("albums:$userId") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/users/$userId/albums",
          headers: {"content-type": "application/json"},
        );
        await box.write("albums:$userId", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parseAlbums, box.read<String>("albums:$userId"));
  }
}

List<AlbumModel> parseAlbums(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  AlbumsList albumList = AlbumsList.fromJson(data);
  return albumList.albums;
}
