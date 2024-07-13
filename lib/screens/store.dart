import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/product_provider.dart';
import 'package:store_front_app/widgets/product_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Storefront'),
      ),
      body: Center(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading) {
              return const CircularProgressIndicator();
            } else if (productProvider.isError) {
              return const Text('Failed to load products');
            } else {
              // on success
              return ListView.builder(
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: productProvider.products[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
