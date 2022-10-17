import 'package:exercise_e7/main.dart';
import 'package:exercise_e7/pages/product_page.dart';
import 'package:exercise_e7/widgets/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("(3) No error message by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_findSizeError(), findsNothing);
  });

  testWidgets("(1.1) No item count in cart icon", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getTotalItemCountText(tester), isNull);
  });

  testWidgets("(2) No size selected by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedSize(tester), equals(SizeSelector.noSize));
  });

  testWidgets("(4) count==1 by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_getSelectedCount(tester), equals(1));
  });

  testWidgets("(5.1) minus button is disabled by default", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isFalse);
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
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isFalse);
    await _tapPlus(tester);
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isTrue);
  });

  testWidgets("(5) minus button disabled when count becomes 1", (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isFalse);
    await _tapPlus(tester);
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isTrue);
    await _tapMinus(tester);
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isFalse);
    await _tapPlus(tester, times: 3);
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isTrue);
    await _tapMinus(tester, times: 3);
    expect(_isIconButtonEnabled(ProductPage.minusButtonKey, tester), isFalse);
  });

  // TODO (5.2) can't press + when count is 10
  // TODO (5) can press + 9 times, then - once, then + again. Count is 10

  // TODO (7) The "Add to cart" button is enabled by default

  // TODO (8.1.1) when trying to add a product with no size to the cart - show error

  // TODO (8.2) Can add one M-size t-shirt to the cart:
  //    - (7) the button works
  //    - no error shown
  //    - (1.2) action bar shows 1 after the product is added

  // TODO (8.2) Can add one L-size t-shirt to the cart
  //    - same conditions as previous test

  // TODO (8.2) Can add 3 L-size t-shirts to the cart
  //    - the button works
  //    - no error shown
  //    - action bar shows 3 after the product is added

  // TODO (8.2) Can add 2 L-size and then 3 L-size to the cart:
  //    - the button works
  //    - no error shown
  //    - action bar shows 5 after the products are added

  // TODO (8.2) can add 2 L-size and then 3 S-size to the cart:
  //    - the button works
  //    - no error shown
  //    - action bar shows 5 after the products are added

  // TODO (9) Click to the cart icon opens shopping cart page

  // TODO (10) By default, the shopping cart page shows "No items in the cart"

  // TODO (11) when one product is added, it is displayed in the cart

  // TODO (11) add 2 L-size and then 3 L-size to the cart. These must be visible correctly in the cart

  // TODO (12) Delete icon visible when 1 item in the cart

  // TODO (12) When pressing on the delete icon (for a single-item cart), the cart becomes empty, "The cart is empty" text is shown

  // TODO (12) When pressing on the delete icon on the 1st of 3 items (2xS shirts, 3xM shirts, 1x XL shirt), the first item disappears

  // TODO (12, 1) When pressing on the delete icon on the 1st of 3 items (2xS shirts, 3xM shirts, 1x XL shirt), the first item disappears. When we go back to the product page, the number of items in the cart is updated.

  // TODO (12) When pressing on the delete icon on the 2nd of 3 items (2xS shirts, 3xM shirts, 1x XL shirt), the 2nd item disappears

  // TODO (12) When pressing on the delete icon on the 3rd of 3 items (2xS shirts, 3xM shirts, 1x XL shirt), the 3rd item disappears

  // TODO (12) When pressing on the first and then 3rd delete icon, only the 2nd item remains in the cart

  // TODO (12, 8) When adding three items to the cart, then deleting all of them, we get the "The cart is empty" text again
}

/// Get the count number displayed in the AppBar
int? _getTotalItemCountText(WidgetTester tester) {
  final Finder counterFinder = find.byKey(ProductPage.cartItemCountKey);
  try {
    Text? widget = tester.widget<Text>(counterFinder);
    String? value = widget.data;
    return value != null ? int.parse(value) : null;
  } catch (e) {
    return null;
  }
}

/// Find the error message complaining about size not being chosen
Finder _findSizeError() {
  return find.text("Choose the size first");
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

/// Tap on the given button (found by the key) specified number of times
Future<void> _tapButton(WidgetTester tester, Key key, {int times = 1}) async {
  final Finder button = find.byKey(key);
  for (var i = 0; i < times; ++i) {
    await tester.tap(button);
  }
}

/// Check whether button with given title is enabled
/// return: True if it is enabled, false if not.
bool _isIconButtonEnabled(Key buttonKey, WidgetTester tester) {
  final IconButton button = tester.widget(find.byKey(buttonKey));
  return button.onPressed != null;
}
