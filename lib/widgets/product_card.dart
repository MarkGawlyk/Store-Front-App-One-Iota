import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:store_front_app/models/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:store_front_app/screens/product_page.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  initState() {
    super.initState();
  }

  String _getCurrency() {
    if (widget.product.price.currency == 'USD') {
      return '\$';
    } else if (widget.product.price.currency == 'EUR') {
      return '€';
    } else if (widget.product.price.currency == 'GBP') {
      return '£';
    } else {
      return ' ${widget.product.price.currency}';
    }
  }

  void _onTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductPage(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Color.fromARGB(22, 158, 158, 158),
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 10),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.product.brandName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${_getCurrency()}${widget.product.price.amount}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.product.mainImage == null
                    ? const SizedBox(height: 140, width: 140)
                    : CachedNetworkImage(
                        fadeInDuration: const Duration(milliseconds: 100),
                        imageUrl: widget.product.mainImage!,
                        width: 140,
                        height: 140,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                          baseColor: const Color.fromARGB(90, 224, 224, 224)!,
                          highlightColor:
                              const Color.fromARGB(34, 245, 245, 245)!,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const SizedBox(),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
