import 'package:exercise_e7/model/cart_item.dart';

/// Represents size and count
/// Used for tests only. For logic-code use CartItem
class SizeAndCount {
  final String? size;
  final int count;

  SizeAndCount(this.size, this.count);

  SizeAndCount.fromItem(CartItem item)
      : size = item.size,
        count = item.count;

  @override
  String toString() {
    return '${count}x$size';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeAndCount &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          count == other.count;

  @override
  int get hashCode => size.hashCode ^ count.hashCode;
}
