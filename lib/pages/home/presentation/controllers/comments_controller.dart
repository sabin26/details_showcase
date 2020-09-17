import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/comment_model.dart';
import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/posts_controller.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class CommentsController extends GetxController {
  CommentsController({this.commentRepository});

  final ICommentRepository commentRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<CommentModel> comments;

  final PostModel post = Get.find<PostsController>().selectedPost;

  @override
  void onInit() => fetchDataFromApi(post.id);

  Future<void> fetchDataFromApi(int postId) async {
    if (status.value != Status.loading) status(Status.loading);
    return commentRepository.getComments(postId).then(
      (data) {
        comments = RxList<CommentModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
