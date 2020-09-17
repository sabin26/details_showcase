import 'package:details_showcase/pages/home/data/photo_repository.dart';
import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/presentation/controllers/photos_controller.dart';
import 'package:get/get.dart';

class PhotosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IPhotoRepository>(() => PhotoRepository(
          client: Get.find(),
          box: Get.find(),
        ));
    Get.lazyPut(
      () => PhotosController(
        photoRepository: Get.find(),
      ),
    );
  }
}
