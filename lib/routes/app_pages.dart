import 'package:details_showcase/pages/home/bindings/comments_binding.dart';
import 'package:details_showcase/pages/home/bindings/home_binding.dart';
import 'package:details_showcase/pages/home/bindings/photos_binding.dart';
import 'package:details_showcase/pages/home/bindings/screen_binding.dart';
import 'package:details_showcase/pages/home/presentation/views/data/data_view.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/comments_view.dart';
import 'package:details_showcase/pages/home/presentation/views/data/screens/photo_view.dart';
import 'package:details_showcase/pages/home/presentation/views/home/home_view.dart';
import 'package:details_showcase/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DATA,
      page: () => DataView(),
      binding: ScreenBinding(),
    ),
    GetPage(
      name: Routes.COMMENTS,
      page: () => CommentsView(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: Routes.PHOTOS,
      page: () => PhotosGridView(),
      binding: PhotosBinding(),
    ),
  ];
}
