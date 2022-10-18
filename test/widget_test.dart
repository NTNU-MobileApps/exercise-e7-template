import 'package:exercise_e7/pages/shopping_cart_page.dart';
import 'package:exercise_e7/main.dart';
import 'package:exercise_e7/pages/product_page.dart';
import 'package:exercise_e7/widgets/cart_item_card.dart';
import 'package:exercise_e7/widgets/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'size_and_count.dart';

void main() {
  testWidgets("(0) Size selector works", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _selectSize("M", tester);
    expect(_getSelectedSize(tester), equals("M"));
    await _selectSize("S", tester);
    expect(_getSelectedSize(tester), equals("S"));
    await _selectSize("L", tester);
    expect(_getSelectedSize(tester), equals("L"));
  });

  testWidgets("(1.1) No item count in cart icon", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getTotalItemCountText(tester), 0);
  });

  testWidgets("(2) No size selected by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedSize(tester), equals(SizeSelector.noSize));
  });

  testWidgets("(3) No error message by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isSizeErrorDisplayed(tester), isFalse);
  });

  testWidgets("(4) count==1 by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedCount(tester), equals(1));
  });

  testWidgets("(5.1) minus button is disabled by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isMinusButtonEnabled(tester), isFalse);
  });

  testWidgets("(5) plus button is enabled by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isIconButtonEnabled(ProductPage.plusButtonKey, tester), isTrue);
  });

  testWidgets("(5) pressing + changes the count to 2", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedCount(tester), equals(1));
    await _tapPlus(tester);
    expect(_getSelectedCount(tester), equals(2));
  });

  testWidgets("(5) pressing + twice changes the count to 3", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedCount(tester), equals(1));
    await _tapPlus(tester, times: 2);
    expect(_getSelectedCount(tester), equals(3));
  });

  testWidgets("(5) pressing + enabled the minus button", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isMinusButtonEnabled(tester), isFalse);
    await _tapPlus(tester);
    expect(_isMinusButtonEnabled(tester), isTrue);
  });

  testWidgets("(5) minus button disabled when count becomes 1", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isMinusButtonEnabled(tester), isFalse);
    await _tapPlus(tester);
    expect(_isMinusButtonEnabled(tester), isTrue);
    await _tapMinus(tester);
    expect(_isMinusButtonEnabled(tester), isFalse);
    await _tapPlus(tester, times: 3);
    expect(_isMinusButtonEnabled(tester), isTrue);
    await _tapMinus(tester, times: 3);
    expect(_isMinusButtonEnabled(tester), isFalse);
  });

  testWidgets("(5.2) cannot press + when count is 10", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isPlusButtonEnabled(tester), isTrue);
    await _tapPlus(tester, times: 9);
    expect(_isPlusButtonEnabled(tester), isFalse);
  });

  testWidgets("(5) 9x plus, 1x minus => plus button enabled", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isPlusButtonEnabled(tester), isTrue);
    await _tapPlus(tester, times: 9);
    expect(_isPlusButtonEnabled(tester), isFalse);
    await _tapMinus(tester);
    expect(_isPlusButtonEnabled(tester), isTrue);
  });

  testWidgets("(7.1) Error when add a product with no size", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _tapAdd(tester);
    expect(_isSizeErrorDisplayed(tester), isTrue);
  });

  testWidgets("(7.1) Add a no-size, then M-size: no error", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _tapAdd(tester);
    expect(_isSizeErrorDisplayed(tester), isTrue);
    await _selectSize("M", tester);
    await _tapAdd(tester);
    expect(_isSizeErrorDisplayed(tester), isFalse);
  });

  testWidgets("(7.2) Can add one M-size t-shirt to the cart", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("M", 1, tester);
    await _checkItemsInCart([SizeAndCount("M", 1)], tester);
  });

  testWidgets("(7.2) Can add one L-size t-shirt to the cart", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 1, tester);
    await _checkItemsInCart([SizeAndCount("L", 1)], tester);
  });

  testWidgets("(7.2) Can add 3x L-size t-shirts to the cart", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 3, tester);
    await _checkItemsInCart([SizeAndCount("L", 3)], tester);
  });

  testWidgets("(7.2) Can add 10x L-size t-shirts to the cart", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 10, tester);
    await _checkItemsInCart([SizeAndCount("L", 10)], tester);
  });

  testWidgets("(7.2) Can add 2x L-size and 3x L-size t-shirts to the cart",
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 2, tester);
    await _addToCart("L", 3, tester);
    await _checkItemsInCart(
        [SizeAndCount("L", 2), SizeAndCount("L", 3)], tester);
  });

  testWidgets("(7.2) Can add twice 10x L-size t-shirts to the cart",
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 10, tester);
    await _addToCart("L", 10, tester);
    await _checkItemsInCart(
        [SizeAndCount("L", 10), SizeAndCount("L", 10)], tester);
  });

  testWidgets("(7.2) Can add 2x L-size and 4x S-size t-shirts to the cart",
      (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("L", 2, tester);
    await _addToCart("S", 4, tester);
    await _checkItemsInCart(
        [SizeAndCount("L", 2), SizeAndCount("S", 4)], tester);
  });

  testWidgets("(8) Click to the cart icon opens shopping cart page",
      (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(ShoppingCartPage), findsNothing);
    await _navigateToCart(tester);
    expect(find.byType(ShoppingCartPage), findsOneWidget);
  });

  testWidgets("(9) By default no items in the cart", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _navigateToCart(tester);
    expect(find.byType(CartItemCard), findsNothing);
  });

  testWidgets("(9) By default cart-empty message is shown", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _navigateToCart(tester);
    expect(_isEmptyCartMessageVisible(), isTrue);
  });

  testWidgets("(9) No delete icon when the cart is empty", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _navigateToCart(tester);
    try {
      final Finder trashButton = _findDeleteButton(0);
      expect(false, isTrue); // we should not get this far
    } catch (e) {
      // We expect to get here because the findDeleteButton should throw
      // an exception - no "Delete" button should be found
      expect(true, isTrue);
    }
  });

  testWidgets("(11) Find delete icon for first product", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("M", 1, tester);
    await _navigateToCart(tester);
    final Finder trashButton = _findDeleteButton(0);
    expect(trashButton, findsOneWidget);
  });

  testWidgets("(11) Add and delete a product", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _addToCart("M", 1, tester);
    await _checkItemsInCart([SizeAndCount("M", 1)], tester);
    await _navigateToCart(tester);
    await _deleteItemFromCart(0, tester);
    expect(_isEmptyCartMessageVisible(), isTrue);
  });

  testWidgets("(11) Add three identical products, delete one", (tester) async {
    await tester.pumpWidget(const MyApp());
    await _selectSize("M", tester);
    await _tapAdd(tester);
    await _tapAdd(tester);
    await _tapAdd(tester);
    await _checkItemsInCart(
        [SizeAndCount("M", 1), SizeAndCount("M", 1), SizeAndCount("M", 1)],
        tester);
    await _navigateToCart(tester);
    await _deleteItemFromCart(0, tester);
    await _navigateBack(tester);
    await _checkItemsInCart(
        [SizeAndCount("M", 1), SizeAndCount("M", 1)], tester);
  });

  testWidgets("(11) Add 3 items, delete 1st", (tester) async {
    await _testThreeProductDeletionScenario([0], tester);
  });

  testWidgets("(11) Add 3 items, delete 2nd", (tester) async {
    await _testThreeProductDeletionScenario([1], tester);
  });

  testWidgets("(11) Add 3 items, delete 3rd", (tester) async {
    await _testThreeProductDeletionScenario([2], tester);
  });

  testWidgets("(11) Add 3 items, delete 1st and 3rd", (tester) async {
    // After deleting the 1st item (index 0), the third item has now index 1
    await _testThreeProductDeletionScenario([0, 1], tester);
  });

  testWidgets("(11) Add 3 items, delete all", (tester) async {
    // Delete 2nd (index 1), then 1st (index 0), then the third (index is now 0)
    await _testThreeProductDeletionScenario([1, 0, 0], tester);
  });
}

/// Get the count number displayed in the AppBar
int? _getTotalItemCountText(WidgetTester tester) {
  final Finder counterFinder = find.byKey(ProductPage.cartItemCountKey);
  try {
    Text? widget = tester.widget<Text>(counterFinder);
    String? value = widget.data;
    return value != null ? int.parse(value) : null;
  } catch (e) {
    return 0;
  }
}

/// Check whether  message complaining about size not being chosen is displayed
/// Returns true if the error message is shown, false otherwise
bool _isSizeErrorDisplayed(WidgetTester tester) {
  try {
    tester.widget<Text>(find.text("Choose the size first"));
    return true;
  } catch (e) {
    return false;
  }
}

/// Get the currently selected t-shirt size value
/// Note: does not filter out the "Select size" value, simply returns it!
String _getSelectedSize(WidgetTester tester) {
  final Finder sizeFinder = find.byType(DropdownButton<String>);
  expect(sizeFinder, findsOneWidget);
  final DropdownButton<String> selector = tester.widget(sizeFinder);
  return selector.value!;
}

/// Get currently selected t-shirt count to be added to the cart
/// Note: expects the "Count: c" format, returns c!
int _getSelectedCount(WidgetTester tester) {
  final Finder countFinder = find.byKey(ProductPage.addCountKey);
  expect(countFinder, findsOneWidget);
  final Text widget = tester.widget<Text>(countFinder);
  final String? value = widget.data;
  expect(value, isNotNull);
  expect(value!.substring(0, 7), equals("Count: "));
  return int.parse(value.substring(7));
}

/// Tap on the + button specified number of times
Future<void> _tapPlus(WidgetTester tester, {int times = 1}) async {
  await _tapButton(tester, ProductPage.plusButtonKey, times: times);
}

/// Tap on the - button specified number of times
Future<void> _tapMinus(WidgetTester tester, {int times = 1}) async {
  await _tapButton(tester, ProductPage.minusButtonKey, times: times);
}

/// Tap on the "Add to cart" button
Future<void> _tapAdd(WidgetTester tester) async {
  await _tapButton(tester, ProductPage.addToCartKey, times: 1);
}

/// Tap on the given button (found by the key) specified number of times
Future<void> _tapButton(WidgetTester tester, Key key, {int times = 1}) async {
  final Finder button = find.byKey(key);
  for (var i = 0; i < times; ++i) {
    await tester.tap(button);
    await tester.pump();
  }
}

/// Check whether icon-button with given key is enabled
/// return: True if it is enabled, false if not.
bool _isIconButtonEnabled(Key buttonKey, WidgetTester tester) {
  final IconButton button = tester.widget(find.byKey(buttonKey));
  return button.onPressed != null;
}

/// Check whether the + button is enabled
bool _isPlusButtonEnabled(WidgetTester tester) {
  return _isIconButtonEnabled(ProductPage.plusButtonKey, tester);
}

/// Check whether the - button is enabled
bool _isMinusButtonEnabled(WidgetTester tester) {
  return _isIconButtonEnabled(ProductPage.minusButtonKey, tester);
}

/// Try to add current t-shirt configuration (given size, given count) to cart
/// Assume that at the start of this function the count is equal to 1
/// Throws assert-exception is something fails
Future<void> _addToCart(String size, int count, WidgetTester tester) async {
  await _selectSize(size, tester);
  await _tapPlus(tester, times: count - 1);
  await _tapAdd(tester);
  expect(_isSizeErrorDisplayed(tester), isFalse);

  // Ensure that we reset the count to 1 again
  await _tapMinus(tester, times: count - 1);
}

/// Select the given size
Future<void> _selectSize(String size, WidgetTester tester) async {
  final Finder selector = find.byKey(SizeSelector.selectorKey);
  await tester.tap(selector);
  await tester.pump();
  // Warning: can't select descendant of the DropdownButton here,
  // because the popup-list with values is pushed as a new widget right
  // on the MaterialApp, it is NOT inside the DropdownButton
  final Finder item = find.text(size).last;
  await tester.tap(item);
  await tester.pumpAndSettle();
}

/// Assume that we are on Product page at the start.
/// Check whether the number of items is displayed as expected.
/// Then navigate to ShoppingCart and check if items there are as expected.
/// Then navigate back to the product page
Future<void> _checkItemsInCart(
    List<SizeAndCount> items, WidgetTester tester) async {
  final int totalCount = items.fold(0, (prev, item) => prev + item.count);

  // Check the item count and error message on product page
  print("Expect $totalCount items in the cart");
  expect(_getTotalItemCountText(tester), equals(totalCount));
  expect(_isSizeErrorDisplayed(tester), isFalse);

  // Go to Shopping cart, check the items
  await _navigateToCart(tester);
  final List<SizeAndCount> itemsInCart = _getItemsInCart(tester);
  expect(items, equals(itemsInCart));

  // Go back to product page
  await _navigateBack(tester);
  expect(find.byType(ProductPage), findsOneWidget);
}

/// Get products currently shown in the cart, as SizeAndCount objects
List<SizeAndCount> _getItemsInCart(WidgetTester tester) {
  final Finder cardFinder = find.byType(CartItemCard);
  final Iterable<CartItemCard> cards =
      tester.widgetList<CartItemCard>(cardFinder);
  return cards.map((card) => SizeAndCount.fromItem(card.item)).toList();
}

/// Navigate to the ShoppingCart page
/// We assume that we are currently on the product page
Future<void> _navigateToCart(WidgetTester tester) async {
  final Finder cartIcon = find.byKey(ProductPage.openCartKey);
  expect(cartIcon, findsOneWidget);
  await tester.tap(cartIcon);
  await tester.pumpAndSettle();
}

/// Navigate back to previus page
Future<void> _navigateBack(WidgetTester tester) async {
  await tester.pageBack();
  await tester.pumpAndSettle();
}

/// Find "Delete from cart" icon button with given index
Finder _findDeleteButton(int index) {
  final Finder buttons = find.descendant(
      of: find.byType(CartItemCard), matching: find.byType(IconButton));
  return buttons.at(index);
}

/// Check whether the message "The cart is empty" is currently visible
/// on the screen
/// Returns true if it is, false otherwise
bool _isEmptyCartMessageVisible() {
  final Finder msgFinder = find.text(ShoppingCartPage.emptyCartMessage);
  return msgFinder.evaluate().length == 1;
}

/// Test a scenario where three products are added to the cart, then products
/// with specified indexes are deleted one by one. After each step, check
/// whether the products in the cart match the expectation.
/// Check if "Empty cart" message is shown when no products should be left
/// in the cart
Future<void> _testThreeProductDeletionScenario(
    List<int> itemsToDelete, WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  List<SizeAndCount> products = [
    SizeAndCount("S", 2),
    SizeAndCount("M", 3),
    SizeAndCount("XL", 1),
  ];
  for (final product in products) {
    await _addToCart(product.size!, product.count, tester);
  }
  await _checkItemsInCart(products, tester);

  for (final deleteIndex in itemsToDelete) {
    print("Deleting item with index $deleteIndex...");
    await _navigateToCart(tester);
    await _deleteItemFromCart(deleteIndex, tester);
    products.removeAt(deleteIndex);
    expect(_isEmptyCartMessageVisible(), products.isEmpty);
    await _navigateBack(tester);
    await _checkItemsInCart(products, tester);
  }
}

/// Delete item with given index from the cart by clicking on it's Trash button
/// (Assume we start in shopping cart page)
Future<void> _deleteItemFromCart(int index, WidgetTester tester) async {
  final Finder trashButton = find.byType(IconButton).at(index);
  await tester.tap(trashButton);
  await tester.pumpAndSettle();
}
