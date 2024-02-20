import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Models/cart.model.dart';

class CartSharedPref {
  late SharedPreferences _prefs;

  CartSharedPref();

  Future<void> init(String userId) async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Cart> getCartItem(String userId) {
    print('get trigger');
    List<String> cartJson = _prefs.getStringList(userId) ?? [];
    return cartJson.map((json) => Cart.fromJson(jsonDecode(json))).toList();
  }

  Future<void> addToCart(String userId, Cart carts) async {
    print('add trigger');
    List<String> cartItems = _prefs.getStringList(userId) ?? [];
    int existingIndex = cartItems.indexWhere((item) {
      Cart cart = Cart.fromJson(jsonDecode(item));
      return cart.items.id == carts.items.id;
    });
    if (existingIndex != -1) {
      Cart existingCart = Cart.fromJson(jsonDecode(cartItems[existingIndex]));
      existingCart.quantity += carts.quantity;
      cartItems[existingIndex] = jsonEncode(existingCart.toJson());
    } else {
      cartItems.add(jsonEncode(carts.toJson()));
    }

    await _prefs.setStringList(userId, cartItems);
  }

  Future<void> AdjustQuantity(String userId, Cart carts) async {
    print('add trigger');
    List<String> cartItems = _prefs.getStringList(userId) ?? [];
    int existingIndex = cartItems.indexWhere((item) {
      Cart cart = Cart.fromJson(jsonDecode(item));
      return cart.items.id == carts.items.id;
    });
    if (existingIndex != -1) {
      Cart existingCart = Cart.fromJson(jsonDecode(cartItems[existingIndex]));
      existingCart.quantity = carts.quantity;
      cartItems[existingIndex] = jsonEncode(existingCart.toJson());
    } else {
      cartItems.add(jsonEncode(carts.toJson()));
    }

    await _prefs.setStringList(userId, cartItems);
  }

  Future<void> removeFromCart(String userId, Cart carts) async {
    final List<String> cartJsonList = _prefs.getStringList(userId) ?? [];
    cartJsonList.remove(jsonEncode(carts.toJson()));
    await _prefs.setStringList(userId, cartJsonList);
  }

  Future<void> clearCart(String userId) async {
    await init(userId);
    await _prefs.remove(userId);
  }
}
