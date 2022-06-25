import 'package:c9p/app/components/app_text.dart';
import 'package:flutter/cupertino.dart';

class AppNotDataWidget extends StatelessWidget {
  const AppNotDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: AppText('Không có dữ liệu'),);
  }
}
