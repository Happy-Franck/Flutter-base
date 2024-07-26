import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'product.dart';
import 'product_list.dart'; // Importer le fichier de la liste des produits

class ProductItemScreen extends StatelessWidget {
  final int productId;

  ProductItemScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = products.firstWhere((p) => p.id == productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implémenter la logique de contact ou d'action ici
              },
              child: Text('Contact'),
            ),
          ],
        ),
      ),
    );
  }
}
