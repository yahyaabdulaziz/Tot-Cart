import 'package:tot_cart_task/domain/entities/discount.dart';

abstract class DiscountRepository {
  Future<Discount?> validatePromoCode(String code);
}
