import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/cart_provider.dart';
import 'package:store_front_app/providers/product_provider.dart';
import 'package:store_front_app/services/prefs.dart';
import 'package:store_front_app/widgets/basket_appbar.dart';
import 'package:store_front_app/widgets/product_card.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasketAppBar(
        title: 'Shoe Store',
        backButton: false,
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
                itemCount: productProvider.products.length + 1,
                itemBuilder: (context, index) {
                  if (index == productProvider.products.length) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          clearPrefs().then((value) {
                            productProvider.fetchProducts();
                            Provider.of<CartProvider>(context, listen: false)
                                .fetchItems();
                          });
                        },
                        child: const Text('Reset',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    );
                  } else {
                    return ProductCard(
                        product: productProvider.products[index]);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
