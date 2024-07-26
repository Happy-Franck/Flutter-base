// routes.dart
import 'package:go_router/go_router.dart';
import 'home_screen.dart';
import 'products_screen.dart';
import 'product_item_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => ProductsScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ProductItemScreen(productId: id);
      },
    ),
  ],
);
