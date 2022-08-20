import 'package:c9p/app/components/pin_code/builder/color_builder.dart';
import 'package:c9p/app/components/pin_code/cursor/pin_cursor.dart';
import 'package:c9p/app/components/pin_code/decoration/decoration_boxloose.dart';
import 'package:c9p/app/components/pin_code/widget/pin_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/globals.dart';
import '../theme/app_styles.dart';
import '../theme/colors.dart';

class OtpTextFieldWidget extends StatelessWidget {
  final Function(String text) onChanged;
  final Function(String text) onSubmit;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const OtpTextFieldWidget(
      {Key? key,
      required this.onChanged,
      required this.onSubmit,
      required this.controller,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: 30.w + contentPadding, right: 30.w + contentPadding),
      child: PinInputTextField(focusNode: focusNode,
        controller: controller,
        autoFocus: true,
        pinLength: 4,
        decoration: BoxLooseDecoration(
            strokeWidth: 1.2,
            gapSpace: 25.w,
            strokeColorBuilder: PinListenColorBuilder(
                Colors.black.withOpacity(0.05), Colors.black.withOpacity(0.05)),
            textStyle: typoLargeTextBold600.copyWith(color: colorGreen57)),
        textInputAction: TextInputAction.go,
        enabled: true,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.characters,
        onSubmit: (pin) {
          onSubmit.call(pin);
        },
        onChanged: (pin) {
          onChanged.call(pin);
        },
        enableInteractiveSelection: false,
        cursor: Cursor(
          width: 2,
          color: colorGreen57,
          enabled: true,
        ),
      ),
    );
  }
}
