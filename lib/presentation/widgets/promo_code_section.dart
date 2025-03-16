import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tot_cart_task/presentation/providers/cart_provider/cart_provider.dart';

class PromoCodeSection extends StatefulWidget {
  const PromoCodeSection({super.key});

  @override
  State<PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<PromoCodeSection> {
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Promo Code',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  decoration: InputDecoration(
                    hintText: 'Enter promo code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.blue.shade700),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_promoController.text.isNotEmpty) {
                    cartProvider.applyPromoCode(_promoController.text.trim());
                  }
                },
                child: const Text('APPLY'),
              ),
            ],
          ),
          if (cartProvider.errorMessage != null &&
              cartProvider.errorMessage!.contains('promo code'))
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                cartProvider.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          if (cartProvider.appliedDiscount != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Promo code ${cartProvider.appliedDiscount!.code} applied: ${cartProvider.appliedDiscount!.percentage}% off',
                style: const TextStyle(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
