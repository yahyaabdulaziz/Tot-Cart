import 'package:flutter/material.dart';
import 'package:tot_cart_task/domain/entities/cart_item.dart';
import 'package:tot_cart_task/domain/entities/discount.dart';
import 'package:tot_cart_task/domain/entities/product.dart';
import 'package:tot_cart_task/domain/use_cases/add_to_cart_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/apply_discount_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/get_cart_item_use_case.dart';
import 'package:tot_cart_task/domain/use_cases/remove_from_cart_use_case.dart';

class CartProvider extends ChangeNotifier {
  final AddToCartUseCase _addToCartUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final GetCartItemsUseCase _getCartItemsUseCase;
  final ApplyDiscountUseCase _applyDiscountUseCase;

  List<CartItem> _items = [];
  Discount? _appliedDiscount;
  String? _errorMessage;
  bool _isLoading = false;

  CartProvider({
    required AddToCartUseCase addToCartUseCase,
    required RemoveFromCartUseCase removeFromCartUseCase,
    required GetCartItemsUseCase getCartItemsUseCase,
    required ApplyDiscountUseCase applyDiscountUseCase,
  })  : _addToCartUseCase = addToCartUseCase,
        _removeFromCartUseCase = removeFromCartUseCase,
        _getCartItemsUseCase = getCartItemsUseCase,
        _applyDiscountUseCase = applyDiscountUseCase {
    _loadCartItems();
  }

  List<CartItem> get items => _items;

  Discount? get appliedDiscount => _appliedDiscount;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  double get total {
    final price = subtotal;
    if (_appliedDiscount != null) {
      return _appliedDiscount!.applyDiscount(price);
    }
    return price;
  }

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  Future<void> _loadCartItems() async {
    try {
      _setLoading(true);
      _items = await _getCartItemsUseCase.execute();
      _setErrorMessage(null);
    } catch (e) {
      _setErrorMessage('Failed to load cart items: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToCart(Product product, [int quantity = 1]) async {
    try {
      _setLoading(true);
      await _addToCartUseCase.execute(product, quantity);
      await _loadCartItems();
      _setErrorMessage(null);
    } catch (e) {
      _setErrorMessage('Failed to add product to cart: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      _setLoading(true);
      await _removeFromCartUseCase.execute(productId);
      await _loadCartItems();
      _setErrorMessage(null);
    } catch (e) {
      _setErrorMessage('Failed to remove product from cart: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> applyPromoCode(String code) async {
    try {
      _setLoading(true);
      final discount = await _applyDiscountUseCase.execute(code);

      if (discount != null) {
        _appliedDiscount = discount;
        _setErrorMessage(null);
      } else {
        _appliedDiscount = null;
        _setErrorMessage('Invalid promo code');
      }
    } catch (e) {
      _setErrorMessage('Failed to apply promo code: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
