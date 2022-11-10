import 'package:exercise_e7/model/cart_item.dart';
import 'package:exercise_e7/providers/cart_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/cart_item_card.dart';

/// Represents the "Shopping cart" page
class ShoppingCartPage extends ConsumerWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);
  static const emptyCartMessage = "The cart is empty";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping cart"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          child: Column(
            children: _buildCartItems(ref),
          ),
        ),
      ),
    );
  }

  /// Build a list of cards, displaying the items currently in the cart
  List<Widget> _buildCartItems(WidgetRef ref) {
    final List<CartItem> shoppingCartItems = ref.watch(cartItemProvider);
    if (shoppingCartItems.isNotEmpty) {
      return shoppingCartItems.map((item) => CartItemCard(item)).toList();
    } else {
      return [const Center(child: Text(emptyCartMessage))];
    }
  }
}
