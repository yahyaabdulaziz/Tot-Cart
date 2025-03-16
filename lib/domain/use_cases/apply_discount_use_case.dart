import 'package:tot_cart_task/domain/entities/discount.dart';
import 'package:tot_cart_task/domain/repos/discount_repository.dart';

class ApplyDiscountUseCase {
  final DiscountRepository discountRepository;

  ApplyDiscountUseCase(this.discountRepository);

  Future<Discount?> execute(String promoCode) {
    return discountRepository.validatePromoCode(promoCode);
  }
}
