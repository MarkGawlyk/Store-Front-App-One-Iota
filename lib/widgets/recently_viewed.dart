import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/product_provider.dart';
import 'package:store_front_app/screens/product_page.dart';
import 'package:store_front_app/services/prefs.dart';
import 'package:store_front_app/widgets/product_image.dart';

class RecentlyViewedProducts extends StatefulWidget {
  final String currentSku;
  const RecentlyViewedProducts({super.key, required this.currentSku});

  @override
  State<RecentlyViewedProducts> createState() => _RecentlyViewedProductsState();
}

class _RecentlyViewedProductsState extends State<RecentlyViewedProducts> {
  List<String> recentlyViewedSkus = [];
  bool showRecentlyViewed = false;

  @override
  void initState() {
    super.initState();
    _loadRecents();
  }

  void _loadRecents() async {
    getRecentlyViewed().then((value) {
      setState(() {
        // filter out the current product
        recentlyViewedSkus =
            value.where((element) => element != widget.currentSku).toList();
        if (recentlyViewedSkus.isNotEmpty) {
          showRecentlyViewed = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !showRecentlyViewed
        ? const SizedBox.shrink()
        : Consumer<ProductProvider>(builder: (context, productProvider, child) {
            if (productProvider.isLoading) {
              return const SizedBox.shrink();
            } else if (productProvider.isError) {
              return const SizedBox.shrink();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Recently Viewed',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recentlyViewedSkus.length,
                      itemBuilder: (context, index) {
                        final product = productProvider.products.firstWhere(
                            (element) =>
                                element.sku ==
                                recentlyViewedSkus[
                                    recentlyViewedSkus.length - 1 - index]);
                        return SmallProductImage(
                          productUrl: product.mainImage!,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          });
  }
}
