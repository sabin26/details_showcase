import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/comment_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class CommentRepository implements ICommentRepository {
  CommentRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<CommentModel>> getComments(int postId) async {
    if (box.read("comments:$postId") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/posts/$postId/comments",
          headers: {"content-type": "application/json"},
        );
        await box.write("comments:$postId", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parseComments, box.read<String>("comments:$postId"));
  }
}

List<CommentModel> parseComments(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  CommentsList commentsList = CommentsList.fromJson(data);
  return commentsList.comments;
}
