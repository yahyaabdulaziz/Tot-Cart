import 'package:tot_cart_task/domain/repos/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository cartRepository;

  RemoveFromCartUseCase(this.cartRepository);

  Future<void> execute(String productId) {
    return cartRepository.removeFromCart(productId);
  }
}
