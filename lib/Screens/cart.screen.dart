import 'dart:convert';
import 'package:shopping_app/Controllers/cartSharedPref.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Models/cart.model.dart';

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
      body: Center(
        child: FutureBuilder(
          future: shoppingCart.init(widget.userId), // Initialize with a user ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<Cart> cartItems = shoppingCart
                  .getCartItem(widget.userId); // Retrieve cart items
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartItems[index];
                  return ListTile(
                    title: Text(cartItem.items.title),
                    subtitle:
                        Text('\$${cartItem.items.price.toStringAsFixed(2)}'),
                  );
                },
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
