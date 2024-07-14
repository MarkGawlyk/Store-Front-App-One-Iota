import 'package:flutter/material.dart';
import 'package:store_front_app/models/cart_item_model.dart';
import 'package:store_front_app/utils/formatting.dart';

class CartItemCard extends StatelessWidget {
  final ProcessedCartItem cartItem;
  final Function() onRemoveFromCart;
  const CartItemCard(
      {super.key, required this.cartItem, required this.onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem.product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Size: ${cartItem.size}'),
              Text(
                  '${formatCurrency(cartItem.product.price.currency)}${cartItem.product.price.amount} - x${cartItem.quantity}'),
            ],
          ),
        ),
        TextButton(
          onPressed: onRemoveFromCart,
          style: TextButton.styleFrom(
              primary: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: const Text(
            'Remove',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ]),
    );
  }
}
