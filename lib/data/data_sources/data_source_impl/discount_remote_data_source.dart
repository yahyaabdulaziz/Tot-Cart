import 'package:tot_cart_task/data/data_sources/discount_remote_data_source.dart';
import 'package:tot_cart_task/domain/entities/discount.dart';

class DiscountRemoteDataSourceImpl implements DiscountRemoteDataSource {
  final Map<String, double> validPromos = {
    'promo10': 10.0,
    'promo20': 20.0,
    'promo50': 50.0,
  };

  @override
  Future<Discount?> validatePromoCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (validPromos.containsKey(code)) {
      return Discount(
        code: code,
        percentage: validPromos[code]!,
      );
    }
    return null;
  }
}
