import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PostRepository implements IPostRepository {
  PostRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<PostModel>> getPosts(int userId) async {
    if (box.read("posts:$userId") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/users/$userId/posts",
          headers: {"content-type": "application/json"},
        );
        await box.write("posts:$userId", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parsePosts, box.read<String>("posts:$userId"));
  }
}

List<PostModel> parsePosts(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  PostsList postsList = PostsList.fromJson(data);
  return postsList.posts;
}
