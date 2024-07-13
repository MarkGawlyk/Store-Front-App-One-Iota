import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_front_app/providers/product_provider.dart';
import 'package:store_front_app/screens/store.dart';
import 'package:store_front_app/themes/themes.dart';

void main() {
  runApp(const ShoeStoreApp());
}

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..fetchProducts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoe Store',
        theme: defaultTheme,
        home: const StorePage(),
      ),
    );
  }
}
