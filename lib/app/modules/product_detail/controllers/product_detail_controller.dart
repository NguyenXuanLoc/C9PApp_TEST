import 'package:c9p/app/data/model/product_model.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  ProductModel model = Get.arguments;
  final counter = 1.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void increasing() {
    counter.value += 1;
  }

  void decreasing() {
    if(counter.value <=1) return;
    counter.value -=1;
  }

  @override
  void onClose() {}
}
