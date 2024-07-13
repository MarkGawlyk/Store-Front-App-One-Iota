// shared preferences helper

import 'package:shared_preferences/shared_preferences.dart';

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
