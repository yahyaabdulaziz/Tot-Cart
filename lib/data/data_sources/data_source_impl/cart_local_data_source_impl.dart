import 'package:tot_cart_task/data/data_sources/cart_local_data_source.dart';
import 'package:tot_cart_task/domain/entities/cart_item.dart';
import 'package:tot_cart_task/domain/entities/product.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final List<CartItem> _cartItems = [];

  @override
  Future<List<CartItem>> getCartItems() async {
    return _cartItems;
  }

  @override
  Future<void> addToCart(Product product, [int quantity = 1]) async {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product.id == product.id);

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(product: product, quantity: quantity));
    }
  }

  @override
  Future<void> removeFromCart(String productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.product.id == productId);

    if (existingItemIndex != -1) {
      if (quantity <= 0) {
        _cartItems.removeAt(existingItemIndex);
      } else {
        _cartItems[existingItemIndex].quantity = quantity;
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}
