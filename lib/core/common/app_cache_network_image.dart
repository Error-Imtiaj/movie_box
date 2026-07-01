import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  const AppCacheNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(imageUrl: imageUrl, height: height, width: width);
  }
}
