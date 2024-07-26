// product_item_screen.dart
// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'product_list.dart';
import 'package:go_router/go_router.dart';

class ProductItemScreen extends StatelessWidget {
  final String productId;

  const ProductItemScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = products.firstWhere((p) => p.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/products');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image),
            SizedBox(height: 8.0),
            Text(
              product.name,
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product.price}',
            ),
            SizedBox(height: 16.0),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
