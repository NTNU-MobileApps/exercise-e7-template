# Exercise E7

Repository for exercise E7.
Course [IDATA2503 Mobile applications](https://www.ntnu.edu/studies/courses/IDATA2503)
at [NTNU](https://ntnu.edu), campus [Aalesund](https://www.ntnu.edu/alesund).

## Intention

The intention is to practice implementing business logic separately from the user interface. The
suggested way to solve the exercise is to use the [Riverpod library](https://riverpod.dev/).
However, you are allowed to use whatever methods you find reasonable.

## Hand-in process

Clone the template repository within GitHub Classroom. Use the invitation link you got from
Blackboard! Get the automated tests passing.

**To pass the assignment approved you need to get at least 180 points (pass 18 tests).**

## Testing

As always, you can run `flutter test` inside the project folder to run all the tests. As an
alternative, use the testing features in your IDE - right-click on the necessary places, etc. You
know the drill ;)

P.S. Remember how you can run tests in a single test-file? `flutter test test/step_1_1_test.dart`
etc.

## Background

Here in this repo you have a skeleton of a Flutter application. The UI is ready - it shows dummy
data. **Your task is to implement the necessary logic and bind it together with the UI.**

The application is a "product page" of an online show, where the user sees one particular product: a
t-shirt. The user is tne allowed to choose the size of the t-shirt and how many t-shirts one wants.
Then the user can add the chosen t-shirt(s) to the shopping cart by pressing "Add to cart". After
that the user can click on the shopping cart icon at the top-right and see the items currently in
the cart. The user can then delete individual items from the cart by pressing on the trash can next
to each shopping-cart item.

It is suggested to use the providers from [Riverpod library](https://riverpod.dev/), but you can use
other approaches (scoped access with the provider package, dependency injection combined with
lifting state up, global access, etc.).

While the unit tests will only check that the end result is right (when the user clicks on a button
x, the output of UI changes in the expected way), I really encourage you to challenge yourself - get
the least possible amount of logic in the UI, and move most of the logic into separate service
classes and store application state in _state providers_! You will meet similar challenges in your
project, therefore it is good to struggle (i.e., practice) now.

## Instructions

Here are the rules of logic you need to implement:

1. The number to the left of the shopping cart icon on top-right must show number of items in the
   shopping cart, with the following rules:
    1. When the cart is empty, there must be no number at all (the number must be removed)
    2. Otherwise the number must represent the total number of t-shirts in the cart. For example, if
       the user adds to M-size t-shirts to the cart, and after that she adds three more L-size
       t-shirts, this number must show 5, because there are 5 t-shirts in the cart.
    3. Use `key="cart_item_count_text"` for the Text widget displaying the number of items,
       otherwise some tests won't work.
2. The size selector must be "unselected by default", i.e, when the user opens the app, the "Select
   size" must be chosen (this is already implemented at the moment, don't change it).
3. No error message is visible by default.
4. The count has value 1 by default.
5. The user can press on the + and - buttons and change the desired t-shirt count with the following
   rules:
    1. When the count reaches 1, the - button is disabled (the count can't go below 1).
    2. When the count reaches 10, the + button is disabled (not allowed to add more than 10 shirts
       to the cart at once. However, the total number of t-shirts can be higher than that).
6. The count must be displayed in the text field with` key="add_count_text"` in the
   format `Count: <c>`, where `<c>` is replaced by the current count selected by the user.
   Example: `Count: 7`.
7. When the user presses the "Add to cart" button:
    1. If no size is selected:
        1. An error message saying "Choose the size first" must be shown.
    2. If a size is selected:
        1. The selected count of t-shirts of selected size are added to a cart, as a "single"
           item. See the `CartItem` class. The shopping cart must be stored somewhere in your "
           state storage" (in a provider).
        2. The number next to the shopping cart icon is updated accordingly to display the current
           number of t-shirts in the cart.
        3. The error message is hidden (if it was visible).
8. When the user presses on the cart icon (or the number next to it), the shopping cart page is
   opened (this is implemented already, don't break it ;)).
9. If the shopping cart is empty, instead of displaying a `CartItemCard` list, the shopping cart
   page must show a text saying "The cart is empty".
10. The shopping cart page must display the items currently in the cart (`CartItem` objects). Use
    the
    `CartItemCard` widget, this is provided already. Just make sure you connect the real content of
    the shopping cart in your state storage (logic) to the UI:
    1. The items in the shopping cart must show correct count and sizes.
    2. The items in the cart must be in the order of adding, top-down. For example, if the user
       chooses 2x M-size shirts, and 3x L-size shirts, the "2x Green T-shirt, size M" must be shown
       first (on top), the "3x Green T-shirt, size L" is shown second (bottom).
11. When the user clicks on a trash can on the right side of a `CartItemCard`, the corresponding
    item must be deleted from the cart and:
    1. The list of products in the shopping cart page must be updated.
    2. The number of products in the cart (in the product page) must also be automatically updated.

The unit tests check these rules. Run the tests locally before committing to GitHub!

## Example code

In case you decide to use Riverpod, check out
these [example Flutter apps showing Riverpod use](https://github.com/NTNU-MobileApps/riverpod-examples)
.
