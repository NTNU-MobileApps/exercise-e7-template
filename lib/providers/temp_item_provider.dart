import 'package:exercise_e7/model/cart_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the temporary item the user is configuring to be added to the cart
class TempItemNotifier extends StateNotifier<CartItem> {
  TempItemNotifier() : super(CartItem(CartItem.defaultProductName, null, 1));

  /// Returns true if the user is allowed to increase the count
  bool isIncrementAllowed() {
    return state.count < 10;
  }

  /// Returns true if the user is allowed to decrease the count
  bool isDecrementAllowed() {
    return state.count > 1;
  }

  /// Increase the count for products in the "temporary cart item"
  void increment() {
    if (isIncrementAllowed()) {
      state = CartItem(state.name, state.size, state.count + 1);
    }
  }

  /// Decrease the count for products in the "temporary cart item"
  void decrement() {
    if (isDecrementAllowed()) {
      state = CartItem(state.name, state.size, state.count - 1);
    }
  }

  /// Set the seize for products in the "temporary cart item"
  void setSize(String? size) {
    print("Setting size to $size");
    state = CartItem(state.name, size, state.count);
  }
}

final tempItemProvider =
    StateNotifierProvider<TempItemNotifier, CartItem>((ref) {
  return TempItemNotifier();
});
