import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:store_front_app/models/product_model.dart';

class ProductService {
  static final ProductService _instance = ProductService._internal();
  factory ProductService() => _instance;
  ProductService._internal();

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://s3-eu-west-1.amazonaws.com/api.themeshplatform.com/products.json'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
