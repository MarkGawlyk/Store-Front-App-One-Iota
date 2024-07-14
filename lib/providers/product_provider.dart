import 'package:flutter/material.dart';
import 'package:store_front_app/models/product_model.dart';
import 'package:store_front_app/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  bool _isError = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  // fetch products and update the provider
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = await ProductService().fetchProducts();
      _products = data;
      _isLoading = false;
    } catch (e) {
      print(e);
      _isLoading = false;
      _isError = true;
    }

    notifyListeners();
  }
}
