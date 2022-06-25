import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final isMale = true.obs;
  final ImagePicker _picker = ImagePicker();
  final imageUri = ''.obs;

  void picImage(bool isCamera) async {
    XFile? file = isCamera
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    Get.back();
    if (file != null) {
      imageUri.value = file.path;
    }
  }

  void changeSex() => isMale.value = !isMale.value;
}
