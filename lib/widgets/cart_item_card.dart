import 'package:exercise_e7/providers/cart_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/cart_item.dart';

/// Creates a Card displaying a single shopping-cart item
class CartItemCard extends ConsumerWidget {
  final CartItem item;

  const CartItemCard(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/tshirt.jpg", height: 30),
              const SizedBox(width: 16),
              Text(
                "${item.count}x ${item.name}, size ${item.size}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () => _delete(ref),
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _delete(WidgetRef ref) {
    print("Deleting item, ID=${item.id} ...");
    ref.read(cartItemProvider.notifier).delete(item.id);
  }
}
