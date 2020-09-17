import 'package:details_showcase/pages/home/data/comment_repository.dart';
import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/presentation/controllers/comments_controller.dart';
import 'package:get/get.dart';

class CommentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ICommentRepository>(
      () => CommentRepository(
        client: Get.find(),
        box: Get.find(),
      ),
    );
    Get.lazyPut(
      () => CommentsController(
        commentRepository: Get.find(),
      ),
    );
  }
}
