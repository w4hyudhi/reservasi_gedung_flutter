import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  const CustomCacheImage({Key? key, required this.imageUrl, this.fit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit == null ? BoxFit.fill : fit,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      placeholder: (context, url) => Container(
        color: Colors.grey[300],
        child: Icon(
          Icons.image,
          size: 50,
          color: Colors.grey,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[300],
        child: Icon(Icons.error),
      ),
    );
  }
}
