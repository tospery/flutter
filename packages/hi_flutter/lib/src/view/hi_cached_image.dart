import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HiCachedImage extends StatelessWidget {
  final String uri;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const HiCachedImage({
    super.key,
    required this.uri,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      placeholder: (BuildContext context, String url) =>
          Container(color: Colors.grey[200]),
      errorWidget: (BuildContext context, String url, dynamic error) =>
          const Icon(Icons.error),
      imageUrl: uri,
    );
  }
}
