import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class AlbumsController extends GetxController {
  AlbumsController({this.albumRepository});

  final IAlbumRepository albumRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<AlbumModel> albums;

  final UserModel user = Get.find<HomeController>().selectedUser;

  AlbumModel selectedAlbum;

  @override
  void onInit() => fetchDataFromApi(user.id);

  void setAlbum(AlbumModel album) {
    selectedAlbum = album;
  }

  void resetAlbum() {
    selectedAlbum = null;
  }

  Future<void> fetchDataFromApi(int userId) async {
    if (status.value != Status.loading) status(Status.loading);
    return albumRepository.getAlbums(userId).then(
      (data) {
        albums = RxList<AlbumModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
