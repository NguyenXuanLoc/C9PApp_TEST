import 'package:c9p/app/components/app_text.dart';
import 'package:c9p/app/config/app_translation.dart';
import 'package:c9p/app/theme/app_styles.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppNotDataWidget extends StatelessWidget {
  const AppNotDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: AppText(
          LocaleKeys.not_data_pull_to_refresh.tr,
          textAlign: TextAlign.center,
          style: typoSuperSmallTextBold.copyWith(
            color: colorText60,
          ),
        ),
      ),
    );
  }
}
