import 'package:tot_cart_task/domain/entities/product.dart';
import 'package:tot_cart_task/domain/repos/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository cartRepository;

  AddToCartUseCase(this.cartRepository);

  Future<void> execute(Product product, [int quantity = 1]) {
    return cartRepository.addToCart(product, quantity);
  }
}
