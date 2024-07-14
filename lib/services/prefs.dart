// shared preferences helper

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_front_app/models/cart_item_model.dart';

// clear all shared preferences
Future<void> clearPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

// add a product to recently viewed passed sku
Future<void> addRecentlyViewed(String sku) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> recentlyViewed =
      prefs.getStringList('recentlyViewed') ?? [];
  if (!recentlyViewed.contains(sku)) {
    recentlyViewed.add(sku);
    await prefs.setStringList('recentlyViewed', recentlyViewed);
  }
}

// get recently viewed products
Future<List<String>> getRecentlyViewed() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getStringList('recentlyViewed') ?? [];
}

// add item to cart
Future<void> addCartItem(CartItem items) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> basketItems = prefs.getStringList('basketItems') ?? [];
  basketItems.add(jsonEncode(items.toJson()));
  await prefs.setStringList('basketItems', basketItems);
}

// get cart items
Future<List<CartItem>> getCartItems() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> basketItems = prefs.getStringList('basketItems') ?? [];
  return basketItems.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
}

// remove item from cart (all instances)
Future<void> removeCartItem(CartItem item) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> cartItems = prefs.getStringList('basketItems') ?? [];
  final List<String> newCartItems = cartItems
      .where((element) =>
          CartItem.fromJson(jsonDecode(element)).sku != item.sku ||
          CartItem.fromJson(jsonDecode(element)).size != item.size)
      .toList();
  await prefs.setStringList('basketItems', newCartItems);
}
