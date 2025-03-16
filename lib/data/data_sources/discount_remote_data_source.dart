import 'package:tot_cart_task/domain/entities/discount.dart';

abstract class DiscountRemoteDataSource {
  Future<Discount?> validatePromoCode(String code);
}
