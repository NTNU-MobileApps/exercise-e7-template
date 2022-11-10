import 'package:exercise_e7/providers/temp_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A widget for selecting styles
/// Calls the onSelected callback when a new size is selected
/// Note: this must be a StatefulWidget, otherwise the DropdownButton
/// value can't be updated
class SizeSelector extends ConsumerWidget {
  const SizeSelector({Key? key}) : super(key: key);

  static const Key selectorKey = Key("size_selector");

  // Special constant which is not really a size
  static const noSize = "Select size";

  // Allowed sizes
  static const sizes = [noSize, "S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? selectedValue = ref.watch(tempItemProvider).size;

    return DropdownButton<String>(
      key: SizeSelector.selectorKey,
      items: SizeSelector.sizes
          .map((size) => DropdownMenuItem(value: size, child: Text(size)))
          .toList(),
      onChanged: (newSize) => _sizeSelected(newSize, ref),
      value: selectedValue,
    );
  }

  /// This method is called when a new value is selected
  /// call the `onSelected` callback if the selected value is not the "title"
  void _sizeSelected(String? size, WidgetRef ref) {
    ref.read(tempItemProvider.notifier).setSize(size);
  }
}
