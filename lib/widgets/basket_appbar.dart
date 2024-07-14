import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/cart_provider.dart';
import 'package:store_front_app/screens/cart_page.dart';

// app bar widget, two parameters, title (string) and backButton (bool)
class BasketAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool backButton;

  const BasketAppBar({Key? key, required this.title, required this.backButton})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 4,
      shadowColor: const Color.fromARGB(63, 181, 181, 181),
      leading: backButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        CartIcon(onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            isDismissible: true,
            builder: (context) {
              return const CartPage();
            },
          );
        }),
      ],
    );
  }
}

class CartIcon extends StatelessWidget {
  final Function() onTap;
  const CartIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_basket,
                  color: Colors.black,
                ),
                onPressed: onTap,
              ),
            ),
            if (cartProvider.items.isNotEmpty)
              Positioned(
                right: 5,
                top: 0,
                child: Container(
                  width: 24,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 253, 58, 44),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      cartProvider.items.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
