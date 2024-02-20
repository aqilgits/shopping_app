import 'package:shopping_app/Controllers/cartSharedPref.controller.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Models/cart.model.dart';
import 'package:shopping_app/Controllers/items.controller.dart';
import 'package:shopping_app/Models/user.model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.userId, required this.user});
  final String userId;
  final User user;

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  final CartSharedPref shoppingCart = CartSharedPref();
  late int _counter;
  double _totalPrice = 0.0;
  List<Cart> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _counter = 1;
    _calculateTotalPrice();
    _fetchCartItems();
  }

  void _fetchCartItems() async {
    await shoppingCart.init(widget.userId);
    setState(() {
      _cartItems = shoppingCart.getCartItem(widget.userId);
      _calculateTotalPrice();
    });
  }

  void _incrementCounter(int count) {
    setState(() {
      _counter = count + 1;
    });
  }

  void _calculateTotalPrice() async {
    await shoppingCart.init(widget.userId);
    final List<Cart> cartItems = shoppingCart.getCartItem(widget.userId);
    double totalPrice = 0.0;

    for (var cartItem in cartItems) {
      double discountedPrice = ItemController().calcDiscount(
        cartItem.items.price,
        cartItem.items.discountPercentage,
      );
      double itemTotalPrice = discountedPrice * cartItem.quantity;
      totalPrice += itemTotalPrice;
    }

    setState(() {
      _totalPrice = double.parse(totalPrice.toStringAsFixed(2));
    });
  }

  void _decrementCounter(int count) {
    setState(() {
      int check = count - 1;
      if (check < 1) {
        _counter = 1;
      } else {
        _counter = count - 1;
      }
    });
  }

  void _clearCart() {
    shoppingCart.clearCart(widget.userId);
    setState(() {
      _cartItems.clear();
      _totalPrice = 0.0;
    });
    _fetchCartItems(); // Fetch updated cart items
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(31, 190, 190, 190)),
        child: FutureBuilder(
          future: shoppingCart.init(widget.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<Cart> cartItems =
                  shoppingCart.getCartItem(widget.userId);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Image.network(
                                        cartItem.items.thumbnail,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            cartItem.items.title,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'RM${ItemController().calcDiscount(cartItem.items.price, cartItem.items.discountPercentage)}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          // padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 1.0),
                                                  minimumSize:
                                                      const Size(20, 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: const BorderSide(
                                                          color: Colors.red)),
                                                ),
                                                onPressed: () async {
                                                  _decrementCounter(
                                                      cartItem.quantity);
                                                  final CartSharedPref
                                                      shoppingCart =
                                                      CartSharedPref();
                                                  await shoppingCart
                                                      .init('123');
                                                  await shoppingCart
                                                      .adjustQuantity(
                                                          '123',
                                                          Cart(
                                                              quantity:
                                                                  _counter,
                                                              user:
                                                                  widget.userId,
                                                              items: cartItem
                                                                  .items));

                                                  _calculateTotalPrice();
                                                },
                                                child: const Text(
                                                  '-',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              Text(
                                                '${cartItem.quantity}',
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 1.0),
                                                  minimumSize:
                                                      const Size(20, 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: const BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  _incrementCounter(
                                                      cartItem.quantity);

                                                  final CartSharedPref
                                                      shoppingCart =
                                                      CartSharedPref();
                                                  await shoppingCart
                                                      .init('123');
                                                  await shoppingCart
                                                      .adjustQuantity(
                                                          '123',
                                                          Cart(
                                                              quantity:
                                                                  _counter,
                                                              user:
                                                                  widget.userId,
                                                              items: cartItem
                                                                  .items));

                                                  _calculateTotalPrice();
                                                },
                                                child: const Text(
                                                  '+',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'RM$_totalPrice',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.055),
                              ),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.red)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('Clear cart');
                                _clearCart();
                              },
                              child: const Text(
                                'Clear Cart',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(0)),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                print('buy now');
                              },
                              child: const Text(
                                'Checkout',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
