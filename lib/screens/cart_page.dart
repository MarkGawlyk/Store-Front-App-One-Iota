import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/models/cart_item_model.dart';
import 'package:store_front_app/models/product_model.dart';
import 'package:store_front_app/providers/cart_provider.dart';
import 'package:store_front_app/providers/product_provider.dart';
import 'package:store_front_app/services/prefs.dart';
import 'package:store_front_app/utils/formatting.dart';
import 'package:store_front_app/widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 50),
              const Text(
                'Shopping Cart',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              if (cartProvider.isLoading) {
                return const CircularProgressIndicator();
              } else if (cartProvider.isError) {
                return const Text('Failed to load items');
              } else {
                return Consumer<ProductProvider>(
                  builder: (context, productProvider, child) {
                    final anyItems = cartProvider.items.isNotEmpty;
                    // convert list of cartItems to a list of cartItem quantity pairs
                    List<CartItem> cartItems = cartProvider.items;
                    List<ProcessedCartItem> processedCartItems = [];

                    void removeEntry(CartItem cartItem) {
                      removeCartItem(cartItem);
                      cartProvider.fetchItems();
                    }

                    for (CartItem cartItem in cartItems) {
                      var entry = processedCartItems.firstWhere((element) {
                        return element.sku == cartItem.sku &&
                            element.size == cartItem.size;
                      }, orElse: () {
                        Product product =
                            productProvider.products.firstWhere((element) {
                          return element.sku == cartItem.sku;
                        });
                        return ProcessedCartItem(
                          sku: cartItem.sku,
                          size: cartItem.size,
                          product: product,
                          quantity: 0,
                        );
                      });

                      if (entry.quantity == 0) {
                        entry.quantity = 1;
                        processedCartItems.add(entry);
                      } else {
                        processedCartItems.remove(entry);
                        entry.quantity += 1;
                        processedCartItems.add(entry);
                      }
                    }

                    double totalPrice = 0;
                    String currency = '';
                    for (ProcessedCartItem entry in processedCartItems) {
                      totalPrice += double.parse(entry.product.price.amount) *
                          entry.quantity;

                      if (currency == 'Multiple') {
                        continue;
                      } else if (currency == '') {
                        currency = entry.product.price.currency;
                      } else if (currency != entry.product.price.currency) {
                        currency = 'Multiple';
                      }
                    }

                    return anyItems
                        ? ListView.builder(
                            itemCount: processedCartItems.length + 1,
                            itemBuilder: (context, index) {
                              if (index == processedCartItems.length) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Total'),
                                          Text(
                                            '${formatCurrency(currency)}${totalPrice.toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: const Text(
                                            'Checkout',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (processedCartItems[index].quantity ==
                                  0) {
                                return Container();
                              } else {
                                return CartItemCard(
                                  cartItem: processedCartItems[index],
                                  onRemoveFromCart: () {
                                    removeEntry(cartItems[index]);
                                  },
                                );
                              }
                            },
                          )
                        : const Center(
                            child: Text('No items in the basket'),
                          );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
