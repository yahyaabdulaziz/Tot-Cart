import 'package:tot_cart_task/data/data_sources/data_source_impl/discount_remote_data_source.dart';
import 'package:tot_cart_task/domain/entities/discount.dart';
import 'package:tot_cart_task/domain/repos/discount_repository.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountRemoteDataSourceImpl remoteDataSource;

  DiscountRepositoryImpl(this.remoteDataSource);

  @override
  Future<Discount?> validatePromoCode(String code) {
    return remoteDataSource.validatePromoCode(code);
  }
}
