import 'package:flutter/material.dart';

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
        IconButton(
          icon: const Icon(
            Icons.shopping_basket,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
