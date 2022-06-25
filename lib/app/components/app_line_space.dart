import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class AppLineSpace extends StatelessWidget {
  const AppLineSpace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorSeparatorListView,
      height: 10.h,
      width: MediaQuery.of(context).size.width,
    );
  }
}
