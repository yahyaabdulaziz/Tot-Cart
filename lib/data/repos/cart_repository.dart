import 'package:tot_cart_task/data/data_sources/cart_local_data_source.dart';
import 'package:tot_cart_task/domain/entities/cart_item.dart';
import 'package:tot_cart_task/domain/entities/product.dart';
import 'package:tot_cart_task/domain/repos/cart_repository.dart';

class CartRepositoryData implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryData(this.localDataSource);

  @override
  Future<List<CartItem>> getCartItems() {
    return localDataSource.getCartItems();
  }

  @override
  Future<void> addToCart(Product product, [int quantity = 1]) {
    return localDataSource.addToCart(product, quantity);
  }

  @override
  Future<void> removeFromCart(String productId) {
    return localDataSource.removeFromCart(productId);
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) {
    return localDataSource.updateQuantity(productId, quantity);
  }

  @override
  Future<void> clearCart() {
    return localDataSource.clearCart();
  }
}
