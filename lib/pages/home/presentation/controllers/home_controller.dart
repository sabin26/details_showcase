import 'package:details_showcase/pages/home/domain/adapters/repositary_adapter.dart';
import 'package:details_showcase/pages/home/domain/entity/user_model.dart';
import 'package:get/get.dart';

enum Status { loading, success, error }

class HomeController extends GetxController {
  HomeController({this.homeRepository});

  final IHomeRepository homeRepository;

  final Rx<Status> status = Status.loading.obs;

  RxList<UserModel> users;

  UserModel selectedUser;

  @override
  void onInit() => fetchDataFromApi();

  void setUser(UserModel user) {
    selectedUser = user;
  }

  void resetUser() {
    selectedUser = null;
  }

  Future<void> fetchDataFromApi() async {
    if (status.value != Status.loading) status(Status.loading);
    return homeRepository.getUsers().then(
      (data) {
        users = RxList<UserModel>(data);
        status(Status.success);
      },
      onError: (err) {
        print("$err");
        return status(Status.error);
      },
    );
  }
}
