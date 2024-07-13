import 'package:flutter/material.dart';
import 'package:store_front_app/models/product_model.dart';
import 'package:store_front_app/utils/formatting.dart';
import 'package:store_front_app/widgets/add_product_button.dart';
import 'package:store_front_app/widgets/basket_appbar.dart';
import 'package:store_front_app/widgets/product_image.dart';
import 'package:store_front_app/widgets/size_selector.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String _getTitle() {
    if (widget.product.brandName == null) {
      return widget.product.sku;
    } else {
      return '${widget.product.brandName!} - ${widget.product.sku}';
    }
  }

  bool _inStock() {
    return widget.product.stockStatus == 'IN STOCK';
  }

  String _getDescription() {
    return clearSpecialCharacters(widget.product.description);
  }

  String _getPrice() {
    return '${formatCurrency(widget.product.price.currency)}${widget.product.price.amount}';
  }

  String selectedSize = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasketAppBar(
        title: _getTitle(),
        backButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            LargeProductImage(productUrl: widget.product.mainImage!),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(22, 158, 158, 158),
                      offset: Offset(0, 2),
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getDescription(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _getPrice(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List of sizes product.sizes
                  _inStock()
                      ? Column(
                          children: [
                            SizeSelector(
                              onSizeSelected: (size) {
                                setState(() {
                                  selectedSize = size;
                                });
                              },
                              sizes: widget.product.sizes!,
                            ),
                            const SizedBox(height: 10),
                            AddProductButton(
                              product: widget.product,
                              size: selectedSize,
                              onAddToBasket: () {},
                            )
                          ],
                        )
                      : const Center(
                          child: Text(
                            'Out of stock',
                            style: TextStyle(
                              color: Color.fromARGB(255, 189, 84, 76),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
