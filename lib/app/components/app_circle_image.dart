import 'dart:io';

import 'package:c9p/app/config/globals.dart';
import 'package:c9p/app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_network_image.dart';

class AppCircleImage extends StatelessWidget {
  final String? url;
  final String? urlError;
  final double? size;
  final String? uri;

  const AppCircleImage(
      {Key? key,
      required this.url,
       this.urlError,
      this.size,
      this.uri})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(100)),
          border: Border.all(color: colorOrange40)),
      child: ClipOval(
          child: SizedBox(
              width: size ?? 46.w,
              height: size ?? 46.w,
              child: uri != null && uri!.isNotEmpty
                  ? Image.file(
                File(uri!),
                fit: BoxFit.cover,
              )
                  : AppNetworkImage(
                source: url,
                errorSource: urlError ?? avatar,
                fit: BoxFit.cover,
              ))),);

  }
}
