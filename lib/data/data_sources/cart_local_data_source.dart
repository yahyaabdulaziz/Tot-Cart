import 'package:tot_cart_task/domain/entities/cart_item.dart';
import 'package:tot_cart_task/domain/entities/product.dart';

abstract class CartLocalDataSource {
  Future<List<CartItem>> getCartItems();

  Future<void> addToCart(Product product, [int quantity = 1]);

  Future<void> removeFromCart(String productId);

  Future<void> updateQuantity(String productId, int quantity);

  Future<void> clearCart();
}
