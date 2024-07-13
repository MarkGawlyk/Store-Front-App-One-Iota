// bottom modal sheet - display items in the basket

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: const Color.fromARGB(63, 181, 181, 181),
        title: const Text(
          'Basket',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const CircularProgressIndicator();
          } else if (cartProvider.isError) {
            return const Text('Failed to load items');
          } else {
            final anyItems = cartProvider.items.isNotEmpty;
            return anyItems
                ? ListView.builder(
                    itemCount: cartProvider.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cartProvider.items[index].sku),
                        subtitle: Text(cartProvider.items[index].size),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {},
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('No items in the basket'),
                  );
          }
        },
      ),
    );
  }
}
