import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LargeProductImage extends StatelessWidget {
  final String productUrl;
  const LargeProductImage({super.key, required this.productUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(22, 158, 158, 158),
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 10,
            ),
          ]),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 100),
        imageUrl: productUrl,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            Shimmer.fromColors(
          baseColor: const Color.fromARGB(90, 224, 224, 224),
          highlightColor: const Color.fromARGB(34, 245, 245, 245),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        errorWidget: (context, url, error) => const SizedBox.shrink(),
      ),
    );
  }
}

class SmallProductImage extends StatelessWidget {
  final String productUrl;
  final Function() onTap;
  const SmallProductImage(
      {super.key, required this.productUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        top: 10,
        bottom: 10,
      ),
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(22, 158, 158, 158),
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 10,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 100),
                imageUrl: productUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Shimmer.fromColors(
                  baseColor: const Color.fromARGB(90, 224, 224, 224),
                  highlightColor: const Color.fromARGB(34, 245, 245, 245),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
