import 'package:flutter/material.dart';

import '../widgets/size_selector.dart';
import 'shopping_cart_page.dart';

/// Represents the product page
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const cartItemCountKey = Key("cart_item_count_text");
  static const addCountKey = Key("add_count_text");
  static const minusButtonKey = Key("minus_button");
  static const plusButtonKey = Key("plus_button");
  static const addToCartKey = Key("add_to_cart_button");
  static const openCartKey = Key("open_cart_button");
  static const String sizeErrorMessage = "Choose the size first";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product page"),
        actions: [_buildShoppingCartButton(context)],
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildProductTitle(),
            _buildImage(),
            const SizeSelector(),
            _buildCountSelectors(),
            _buildButton()
          ],
        ),
      ),
    );
  }

  /// Build the action-button to be shown in the action bar.
  /// On click it takes to the shopping-cart page
  Widget _buildShoppingCartButton(BuildContext context) {
    return Row(
      children: [
        // TODO - this must show the number of items in the cart dynamically:
        //  - When no items in the cart - hide this text (remove the Text widget)
        //  - When one t-shirt added to the cart, this must show "1"
        //  - When two L-sized shirts + three XL-shirts added to the cart, this must show 5 (not 2)
        Text("4", key: cartItemCountKey),
        IconButton(
          key: openCartKey,
          onPressed: () => _showShoppingCartPage(context),
          icon: const Icon(Icons.shopping_cart),
        ),
      ],
    );
  }

  /// Build the title for the product
  Widget _buildProductTitle() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        "A nice t-shirt",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  /// Build the product image
  Widget _buildImage() {
    return Image.asset(
      "images/tshirt.jpg",
      height: 200,
    );
  }

  /// Build the row showing the temporary item count with + and - buttons to
  /// increment and decrement the count
  Widget _buildCountSelectors() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            key: minusButtonKey,
            onPressed: _decrementCount,
            icon: const Icon(Icons.remove),
          ),
          Text("Count: 7", key: addCountKey),
          IconButton(
            key: plusButtonKey,
            onPressed: _incrementCount,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  /// Build the "Add to cart" button
  Widget _buildButton() {
    return ElevatedButton(
      key: addToCartKey,
      onPressed: _addToCart,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Add to cart"),
      ),
    );
  }

  /// This method is called when the user presses on the "+" button -
  /// the count must be increased
  void _incrementCount() {
    print("Count++");
    // TODO - implement the necessary logic
  }

  /// This method is called when the user presses on the "-" button -
  /// the count must be decreased
  void _decrementCount() {
    print("Count--");
    // TODO - implement the necessary logic
  }

  /// This method is called when the user presses on the "Add to cart" button -
  /// a new item must be added to the cart, using the appropriate size and count
  void _addToCart() {
    print("Adding product(s) to the cart...");
    // TODO - implement the necessary logic
  }

  /// Navigate to the shopping cart page
  void _showShoppingCartPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ShoppingCartPage(),
    ));
  }
}
