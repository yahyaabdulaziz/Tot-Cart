import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tot_cart_task/presentation/providers/cart_provider/cart_provider.dart';
import 'package:tot_cart_task/presentation/widgets/cart_item_widget.dart';
import 'package:tot_cart_task/presentation/widgets/order_summary.dart';
import 'package:tot_cart_task/presentation/widgets/promo_code_section.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.errorMessage != null) {
            return Center(child: Text(cartProvider.errorMessage!));
          }

          if (cartProvider.items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final item = cartProvider.items[index];
                    return CartItemWidget(item: item);
                  },
                ),
              ),
              const PromoCodeSection(),
              OrderSummary(
                subtotal: cartProvider.subtotal,
                discount: cartProvider.appliedDiscount,
                total: cartProvider.total,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue.shade700),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Checkout not implemented yet')));
                    },
                    child: const Text('CHECKOUT'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
