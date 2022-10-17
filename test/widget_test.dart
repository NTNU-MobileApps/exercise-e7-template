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

  // TODO (5.1) minus button is disabled by default

  // TODO (5) can press +: changes the count to 2
  // TODO (5) can press + twice, count is 3, + amd - buttons enabled
  // TODO (5.1) can't press - when count is 1
  // TODO (5.2) can't press + when count is 10
  // TODO (5) can press + 9 times, then - once, then + again. Count is 10
  // TODO (5) can press +, then -. Count is 1, - button disabled

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

/// Find the first Text widget inside a given ancestor, return it's text
String? _findTextDescendantOf(Finder ancestor, WidgetTester tester) {
  final Finder textFinder = find.descendant(
    of: ancestor,
    matching: find.byType(Text),
  );
  expect(textFinder, findsOneWidget);
  final Text textWidget = tester.widget<Text>(textFinder);
  return textWidget.data;
}

/// Find the AppBar widget
Finder _findAppBar() {
  return find.byType(AppBar);
}

/// Find the error message complaining about size not being chosen
Finder _findSizeError() {
  return find.text("Choose the size first");
}

String _getSelectedSize(WidgetTester tester) {
  final Finder sizeFinder = find.byType(DropdownButton<String>);
  expect(sizeFinder, findsOneWidget);
  final DropdownButton<String> selector = tester.widget(sizeFinder);
  return selector.value!;
}

int _getSelectedCount(WidgetTester tester) {
  final Finder countFinder = find.byKey(ProductPage.addCountKey);
  expect(countFinder, findsOneWidget);
  final Text widget = tester.widget<Text>(countFinder);
  final String? value = widget.data;
  expect(value, isNotNull);
  expect(value!.substring(0, 7), equals("Count: "));
  return int.parse(value.substring(7));
}
