import 'dart:convert';

import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class HomeRepository implements IHomeRepository {
  HomeRepository({this.client, this.box});
  final http.Client client;
  final GetStorage box;

  @override
  Future<List<UserModel>> getUsers() async {
    if (box.read("users") == null) {
      try {
        final response = await client.get(
          "https://jsonplaceholder.typicode.com/users/",
          headers: {"content-type": "application/json"},
        );
        await box.write("users", response.body);
      } catch (e) {
        print(e.toString());
        return Future.error(e.toString());
      }
    }
    return compute(parseUsers, box.read<String>("users"));
  }
}

List<UserModel> parseUsers(String source) {
  List<dynamic> data = jsonDecode(source) as List<dynamic>;
  UsersList userList = UsersList.fromJson(data);
  return userList.users;
}
