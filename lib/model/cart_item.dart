/// An immutable shopping cart item
class CartItem {
  /// Used to generate unique IDs for the items
  static int _itemCounter = 1;

  final int id;
  final String name;
  final String size;
  final int count;

  /// Create a shopping cart item
  /// name: the name of the product (you can use "Green T-shirt")
  /// size: the size of the product (M, L, etc)
  /// count: how many units of the product are included in this cart-item
  CartItem(this.name, this.size, this.count) : id = _itemCounter++;
}
