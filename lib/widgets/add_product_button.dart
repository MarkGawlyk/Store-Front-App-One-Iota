// button to add to basket,
// passed product and a size
// if size is "", button is disabled

import 'package:flutter/material.dart';
import 'package:store_front_app/models/product_model.dart';

// class AddProductButton extends StatefulWidget {
//   final Product product;
//   final String size;
//   final Function() onAddToBasket;

//   const AddProductButton(
//       {Key? key,
//       required this.product,
//       required this.size,
//       required this.onAddToBasket})
//       : super(key: key);

//   @override
//   State<AddProductButton> createState() => _AddProductButtonState();
// }

// class _AddProductButtonState extends State<AddProductButton> {
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: widget.size.isNotEmpty ? widget.onAddToBasket : null,
//       child: const Text('Add to Basket'),
//     );
//   }
// }

class AddProductButton extends StatelessWidget {
  final Product product;
  final String size;
  final Function() onAddToBasket;

  const AddProductButton(
      {super.key,
      required this.product,
      required this.size,
      required this.onAddToBasket});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: size.isNotEmpty ? onAddToBasket : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: size.isNotEmpty ? Colors.black : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          size.isNotEmpty ? 'Add to Basket' : 'Select a size',
          style: TextStyle(
            color: size.isNotEmpty ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
