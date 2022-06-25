import 'package:flutter/cupertino.dart';

import '../theme/app_styles.dart';

class AppText extends StatelessWidget {
  final String msg;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow? textOverflow;

  const AppText(this.msg,
      {Key? key, this.style, this.textAlign, this.maxLine, this.textOverflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      overflow: textOverflow,
      style: style ?? typoNormalTextRegular,
      textScaleFactor: 1,
      textAlign: textAlign,
      maxLines: maxLine,
    );
  }
}
