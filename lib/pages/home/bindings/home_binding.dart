import 'package:details_showcase/pages/home/data/home_repository.dart';
import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/presentation/controllers/home_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => http.Client());
    Get.lazyPut(() => GetStorage());
    Get.lazyPut<IHomeRepository>(
      () => HomeRepository(
        client: Get.find(),
        box: Get.find(),
      ),
    );
    Get.lazyPut(
      () => HomeController(
        homeRepository: Get.find(),
      ),
    );
  }
}
