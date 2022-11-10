import 'package:exercise_e7/model/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the shopping cart items
class CartItemNotifier extends StateNotifier<List<CartItem>> {
  CartItemNotifier() : super([
  //   CartItem("Shirt", "M", 6),
  // CartItem("Hat", "S", 2)
  ]);

  /// Number of products (units) in the cart.
  /// Note: one item can hold several units of a product
  int totalProductCount() {
    int unitCount = 0;
    for (var item in state) {
      unitCount += item.count;
    }
    return unitCount;
  }
}

final cartItemProvider =
StateNotifierProvider<CartItemNotifier, List<CartItem>>((ref) {
  return CartItemNotifier();
});
