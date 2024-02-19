import 'package:flutter/cupertino.dart';
import 'package:shopping_app/Controllers/cartSharedPref.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app/Models/cart.model.dart';
import 'package:shopping_app/Controllers/items.controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.userId});
  final String userId;

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  final CartSharedPref shoppingCart = CartSharedPref();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(31, 190, 190, 190)),
        child: Center(
          child: FutureBuilder(
            future: shoppingCart.init(widget.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final List<Cart> cartItems =
                    shoppingCart.getCartItem(widget.userId);
                return ListView.builder(
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Image.network(
                                  cartItem.items.thumbnail,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${cartItem.items.title}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'RM${ItemController().calcDiscount(cartItem.items.price, cartItem.items.discountPercentage)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      // padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        children: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 1.0),
                                              minimumSize: const Size(20, 10),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  side: const BorderSide(
                                                      color: Colors.red)),
                                            ),
                                            onPressed: null,
                                            child: const Text(
                                              '-',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 1.0),
                                              minimumSize: const Size(20, 10),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                            ),
                                            onPressed: null,
                                            child: const Text(
                                              '+',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
