import 'package:exercise_e7/model/cart_item.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_item_card.dart';

/// Represents the "Shopping cart" page
class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  static const emptyCartMessage = "The cart is empty";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: _buildCartItems(),
        ),
      ),
    );
  }

  /// Build a list of cards, displaying the items currently in the cart
  List<Widget> _buildCartItems() {
    // TODO - the real items must be stored in the "application state"
    // If you use Riverpod, this should be stored in a provider
    // (probably StateNotifierProvider?)
    final shoppingCartItems = [
      CartItem(CartItem.defaultProductName, "M", 1),
      CartItem(CartItem.defaultProductName, "L", 3),
    ];

    return shoppingCartItems.map((item) => CartItemCard(item)).toList();
  }
}
