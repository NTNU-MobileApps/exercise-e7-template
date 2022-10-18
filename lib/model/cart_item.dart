/// An immutable shopping cart item
class CartItem {
  /// Used to generate unique IDs for the items
  static int _itemCounter = 1;

  // The default product name to use to ensure naming is consistent
  static const defaultProductName = "Green T-shirt";

  final int id;
  final String name;
  final String? size;
  final int count;

  /// Create a shopping cart item
  /// name: the name of the product
  /// size: the size of the product (M, L, etc)
  /// count: how many units of the product are included in this cart-item
  CartItem(this.name, this.size, this.count) : id = _itemCounter++;

  /// Copy a CartItem, set necessary fields (or use the old values)
  CartItem copyWith({String? name, String? size, int? count}) {
    return CartItem(name ?? this.name, size ?? this.size, count ?? this.count);
  }

  @override
  String toString() {
    return 'CartItem{${count}x$size $name, id: $id}';
  }
}
