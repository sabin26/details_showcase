import 'package:get/get.dart';

class ScreenController extends GetxController {
  final RxInt page = 0.obs;
  updateValue(int newValue) => page(newValue);
}
