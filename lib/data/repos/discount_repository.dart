import 'package:tot_cart_task/data/data_sources/discount_remote_data_source.dart';
import 'package:tot_cart_task/domain/entities/discount.dart';
import 'package:tot_cart_task/domain/repos/discount_repository.dart';

class DiscountRepositoryData implements DiscountRepository {
  final DiscountRemoteDataSource remoteDataSource;

  DiscountRepositoryData(this.remoteDataSource);

  @override
  Future<Discount?> validatePromoCode(String code) {
    return remoteDataSource.validatePromoCode(code);
  }
}
