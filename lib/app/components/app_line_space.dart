import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors.dart';

class AppLineSpace extends StatelessWidget {
  final double? height;

  const AppLineSpace({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorSeparatorListView,
      height: height ?? 9.h,
      width: MediaQuery.of(context).size.width,
    );
  }
}
