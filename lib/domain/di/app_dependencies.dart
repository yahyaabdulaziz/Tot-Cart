import 'package:tot_cart_task/data/data_sources/data_source_impl/cart_local_data_source_impl.dart';
import 'package:tot_cart_task/data/data_sources/data_source_impl/discount_remote_data_source.dart';
import 'package:tot_cart_task/data/repos/cart_repository_impl.dart';
import 'package:tot_cart_task/data/repos/discount_repository_impl.dart';
import 'package:tot_cart_task/domain/use_cases/add_to_cart_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/apply_discount_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/get_cart_item_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/remove_from_cart_use_case.dart';
import 'package:tot_cart_task/presentation/providers/cart_provider/cart_provider.dart';

class AppDependencies {
  static CartProvider provideCartProvider() {
    final cartDataSource = CartLocalDataSourceImpl();
    final discountDataSource = DiscountRemoteDataSourceImpl();

    final cartRepository = CartRepositoryImpl(cartDataSource);
    final discountRepository = DiscountRepositoryImpl(discountDataSource);

    final addToCartUseCase = AddToCartUseCase(cartRepository);
    final removeFromCartUseCase = RemoveFromCartUseCase(cartRepository);
    final getCartItemsUseCase = GetCartItemsUseCase(cartRepository);
    final applyDiscountUseCase = ApplyDiscountUseCase(discountRepository);

    return CartProvider(
      addToCartUseCase: addToCartUseCase,
      removeFromCartUseCase: removeFromCartUseCase,
      getCartItemsUseCase: getCartItemsUseCase,
      applyDiscountUseCase: applyDiscountUseCase,
    );
  }
}
