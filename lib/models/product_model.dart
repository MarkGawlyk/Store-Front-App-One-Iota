import 'dart:convert';
import 'package:store_front_app/models/price_model.dart';

class Product {
  final String id;
  final String sku;
  final String name;
  final String? brandName;
  final String? mainImage;
  final Price price;
  final List<String>? sizes;
  final String stockStatus;
  final String? colour;
  final String? description;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.brandName,
    required this.mainImage,
    required this.price,
    required this.sizes,
    required this.stockStatus,
    required this.colour,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      sku: json['SKU'],
      name: json['name'],
      brandName: json['brandName'],
      mainImage: json['mainImage'],
      price: Price.fromJson(json['price']),
      sizes: List<String>.from(json['sizes']),
      stockStatus: json['stockStatus'],
      colour: json['colour'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'SKU': sku,
      'name': name,
      'brandName': brandName,
      'mainImage': mainImage,
      'price': price.toJson(),
      'sizes': sizes,
      'stockStatus': stockStatus,
      'colour': colour,
      'description': description,
    };
  }
}

List<Product> parseProducts(String responseBody) {
  final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
