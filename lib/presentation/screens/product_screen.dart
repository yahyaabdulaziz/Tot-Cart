import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:tot_cart_task/domain/entities/product.dart';
import 'package:tot_cart_task/presentation/providers/cart_provider/cart_provider.dart';
import 'package:tot_cart_task/presentation/screens/cart_screen.dart';
import 'package:tot_cart_task/presentation/widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _cartController;
  late Animation<double> _cartBounceAnimation;

  @override
  void initState() {
    super.initState();
    _cartController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _cartBounceAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 70),
    ]).animate(CurvedAnimation(
      parent: _cartController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products = [
      Product(
        id: '1',
        name: 'Sony WH-1000XM5',
        price: 349.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
      Product(
        id: '2',
        name: 'iPhone 15 Pro',
        price: 999.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
      Product(
        id: '3',
        name: 'MacBook Pro M3',
        price: 1999.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
      Product(
        id: '4',
        name: 'Apple Watch Ultra',
        price: 799.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
      Product(
        id: '5',
        name: 'Samsung S24 Ultra',
        price: 1199.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
      Product(
        id: '6',
        name: 'iPad Pro',
        price: 899.99,
        imageUrl:
            'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=500&auto=format',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tot Shop',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              ScaleTransition(
                scale: _cartBounceAnimation,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const CartScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            )),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart, size: 28),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Consumer<CartProvider>(
                  builder: (context, cart, child) {
                    if (cart.itemCount > 0) {
                      _cartController.forward(from: 0.0);
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 300),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                '${cart.itemCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: ProductCard(product: product),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
