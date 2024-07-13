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
