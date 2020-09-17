import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/album_model.dart';
import 'package:details_showcase/pages/home/domain/entity/photo_model.dart';
import 'package:details_showcase/pages/home/presentation/controllers/albums_controller.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class PhotosController extends GetxController {
  PhotosController({this.photoRepository});

  final IPhotoRepository photoRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<PhotoModel> photos;

  final AlbumModel album = Get.find<AlbumsController>().selectedAlbum;

  @override
  void onInit() => fetchDataFromApi(album.id);

  Future<void> fetchDataFromApi(int albumId) async {
    if (status.value != Status.loading) status(Status.loading);
    return photoRepository.getPhotos(albumId).then(
      (data) {
        photos = RxList<PhotoModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
