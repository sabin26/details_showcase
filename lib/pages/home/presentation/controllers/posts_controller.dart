import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/post_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class PostsController extends GetxController {
  PostsController({this.postRepository});

  final IPostRepository postRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<PostModel> posts;

  final UserModel user = Get.find<HomeController>().selectedUser;

  PostModel selectedPost;

  @override
  void onInit() => fetchDataFromApi(user.id);

  void setPost(PostModel post) {
    selectedPost = post;
  }

  void resetPost() {
    selectedPost = null;
  }

  Future<void> fetchDataFromApi(int userId) async {
    if (status.value != Status.loading) status(Status.loading);
    return postRepository.getPosts(userId).then(
      (data) {
        posts = RxList<PostModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
