import 'package:flutter/material.dart';
import 'package:store_front_app/models/cart_item_model.dart';
import 'package:store_front_app/services/prefs.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  bool _isLoading = true;
  bool _isError = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  Future<void> fetchItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await getCartItems();
      _isLoading = false;
    } catch (e) {
      print(e);
      _isLoading = false;
      _isError = true;
    }
    notifyListeners();
  }
}
