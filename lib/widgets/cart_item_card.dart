import 'package:flutter/material.dart';
import 'package:store_front_app/models/cart_item_model.dart';

class CartItemCard extends StatelessWidget {
  final ProcessedCartItem cartItem;
  final Function() onRemoveFromCart;
  const CartItemCard(
      {super.key, required this.cartItem, required this.onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: ListTile(
        title: Text(cartItem.product.name),
        subtitle: Text('Size: ${cartItem.size}'),
        trailing: Text('Quantity: ${cartItem.quantity}'),
        onTap: onRemoveFromCart,
      ),
    );
  }
}
