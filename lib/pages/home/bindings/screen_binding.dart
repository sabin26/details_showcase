import 'package:details_showcase/pages/home/data/album_repository.dart';
import 'package:details_showcase/pages/home/data/post_repository.dart';
import 'package:details_showcase/pages/home/data/todo_repository.dart';
import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/presentation/controllers/albums_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/posts_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/screen_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todo_dialog_controller.dart';
import 'package:details_showcase/pages/home/presentation/controllers/todos_controller.dart';
import 'package:get/get.dart';

class ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScreenController());

    Get.lazyPut<IPostRepository>(
      () => PostRepository(
        client: Get.find(),
        box: Get.find(),
      ),
    );
    Get.lazyPut<IAlbumRepository>(
      () => AlbumRepository(
        client: Get.find(),
        box: Get.find(),
      ),
    );
    Get.lazyPut<ITodoRepository>(
      () => TodoRepository(
        client: Get.find(),
        box: Get.find(),
      ),
    );

    Get.lazyPut(
      () => PostsController(
        postRepository: Get.find(),
      ),
    );
    Get.lazyPut(
      () => AlbumsController(
        albumRepository: Get.find(),
      ),
    );
    Get.lazyPut(
      () => TodosController(
        todoRepository: Get.find(),
      ),
    );
    Get.lazyPut(
      () => TodoDialogController(),
    );
  }
}
