import 'package:tot_cart_task/domain/entities/cart_item.dart';
import 'package:tot_cart_task/domain/repos/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository cartRepository;

  GetCartItemsUseCase(this.cartRepository);

  Future<List<CartItem>> execute() {
    return cartRepository.getCartItems();
  }
}
