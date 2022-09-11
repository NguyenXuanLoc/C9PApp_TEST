import 'package:c9p/app/data/model/active_xu_model.dart';
import 'package:c9p/app/data/model/user_model.dart';
import 'package:c9p/app/utils/log_utils.dart';
import 'package:c9p/app/utils/storage_utils.dart';
import 'package:get/get.dart';

class ConfirmBuyXuController extends GetxController {
  ActiveXuModel model = Get.arguments;
  UserModel? userModel;
  final userName = ''.obs;

  @override
  void onInit() async {
    getUserInfo();
    super.onInit();
  }

  void getUserInfo() async {
    userModel = await StorageUtils.getUser();
    userName.value = userModel?.data?.userData?.name;
  }
}
