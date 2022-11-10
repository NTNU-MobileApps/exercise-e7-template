import 'package:exercise_e7/model/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the shopping cart items
class CartItemNotifier extends StateNotifier<List<CartItem>> {
  CartItemNotifier() : super([]);

  /// Number of products (units) in the cart.
  /// Note: one item can hold several units of a product
  int totalProductCount() {
    int unitCount = 0;
    for (var item in state) {
      unitCount += item.count;
    }
    return unitCount;
  }

  /// Add an item to the cart
  void add(CartItem item) {
    state = [...state, item];
  }

  /// Delete the item with given ID from the shopping cart
  void delete(int itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }
}

final cartItemProvider =
    StateNotifierProvider<CartItemNotifier, List<CartItem>>((ref) {
  return CartItemNotifier();
});
