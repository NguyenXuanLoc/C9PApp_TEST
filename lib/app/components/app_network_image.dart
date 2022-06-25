import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    Key? key,
    this.source,
    this.style = "none",
    this.fit = BoxFit.contain,
    this.decoration,
    this.errorSource =
        'https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/250x250/Photo-Missing.png',
    this.width,
    this.height,
  }) : super(key: key);
  final String errorSource;
  final String? source;
  final String? style;
  final BoxFit? fit;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return source == null || source!.isEmpty || !source!.startsWith('http')
        ? CachedNetworkImage(
            width: width,
            height: height,
            imageUrl:
                "https://platform-static-files.s3.amazonaws.com/premierleague/photos/players/250x250/Photo-Missing.png",
            /*      placeholder: (context, url) => Center(
              widthFactor: 2,
              heightFactor: 2,
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(
                  color: colorPrimaryCTV24h,
                  strokeWidth: 2.0,
                ),
              ),
            ),*/
            fit: fit ?? BoxFit.fill,
            errorWidget: (context, url, error) => CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: errorSource,
            ),
          )
        : CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: source ?? "",
            /*       placeholder: (context, url) => Center(
              widthFactor: 2,
              heightFactor: 2,
              child: SizedBox(
                width: 24.w,
                height: 24.h,
                child: const CircularProgressIndicator(
                  color: colorPrimaryCTV24h,
                  strokeWidth: 2.0,
                ),
              ),
            ),*/
            fit: fit ?? BoxFit.fill,
            errorWidget: (context, url, error) => CachedNetworkImage(
              width: width,
              height: height,
              imageUrl: errorSource,
            ),
          );
  }
}
