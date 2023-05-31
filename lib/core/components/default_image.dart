
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../config/urls.dart';
import '../functions.dart';
import 'default_error.dart';
import 'full_screen_picture.dart';



class DefaultImage extends StatelessWidget {
  const DefaultImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.clickable = false,
    this.width,
    this.height,
  }) : super(key: key);

  final String? imageUrl;
  final BoxFit? fit;
  final bool clickable;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (clickable) {
      return GestureDetector(
        onTap: () {
          navigateTo(
            context,
            FullScreenPicture(
              imageUrl: Urls.filesUrl + (imageUrl ?? ''),
            ),
          );
        },
        child: image(),
      );
    } else {
      return image();
    }
  }

  Widget image() => CachedNetworkImage(
        imageUrl: Urls.filesUrl + (imageUrl ?? ''),
        fit: fit,
        width: width ?? double.infinity,
        height: height,
        placeholder: (context, url) => const Center(
          child: SizedBox(
            child: CupertinoActivityIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: SizedBox(
            child: DefaultError(),
          ),
        ),
      );
}
