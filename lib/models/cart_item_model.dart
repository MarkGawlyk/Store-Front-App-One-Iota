import 'package:store_front_app/models/product_model.dart';

class CartItem {
  final String sku;
  final String size;

  CartItem({required this.sku, required this.size});

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'size': size,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      sku: json['sku'],
      size: json['size'],
    );
  }
}

// Extend CartItem to include quantity

class ProcessedCartItem extends CartItem {
  int quantity;
  final Product product;

  ProcessedCartItem(
      {required String sku,
      required String size,
      required this.quantity,
      required this.product})
      : super(sku: sku, size: size);

  Map<String, dynamic> toJson() => {
        'sku': sku,
        'size': size,
        'quantity': quantity,
        'product': product.toJson(),
      };

  factory ProcessedCartItem.fromJson(Map<String, dynamic> json) {
    return ProcessedCartItem(
      sku: json['sku'],
      size: json['size'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}
