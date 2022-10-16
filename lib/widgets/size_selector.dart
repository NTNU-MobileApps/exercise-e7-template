import 'package:flutter/material.dart';

/// A widget for selecting styles
/// Calls the onSelected callback when a new size is selected
/// Note: this must be a StatefulWidget, otherwise the DropdownButton
/// value can't be updated
class SizeSelector extends StatefulWidget {
  final Function(String?) onSelected;

  const SizeSelector({Key? key, required this.onSelected}) : super(key: key);

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? selectedValue = _noSize;

  // Special constant which is not really a size
  static const _noSize = "Select size";
  static const _sizes = [_noSize, "S", "M", "L", "XL"];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: _sizes
          .map((size) => DropdownMenuItem(value: size, child: Text(size)))
          .toList(),
      onChanged: _sizeSelected,
      value: selectedValue,
    );
  }

  /// This method is called when a new value is selected
  /// call the `onSelected` callback if the selected value is not the "title"
  void _sizeSelected(String? size) {
    // Update the value in the UI
    setState(() {
      selectedValue = size;
    });
    
    // Notify the listener (parent)
    widget.onSelected(size != _noSize ? size : null);
  }
}
