import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:details_showcase/pages/home/domain/entity/comment_model.dart';
import 'package:details_showcase/pages/home/domain/entity/photo_model.dart';
import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:details_showcase/pages/home/domain/entity/todo_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';

abstract class IHomeRepository {
  Future<List<UserModel>> getUsers();
}

abstract class IPostRepository {
  Future<List<PostModel>> getPosts(int userId);
}

abstract class ICommentRepository {
  Future<List<CommentModel>> getComments(int postId);
}

abstract class IAlbumRepository {
  Future<List<AlbumModel>> getAlbums(int userId);
}

abstract class IPhotoRepository {
  Future<List<PhotoModel>> getPhotos(int albumId);
}

abstract class ITodoRepository {
  Future<List<TodoModel>> getTodos(int userId);
}
