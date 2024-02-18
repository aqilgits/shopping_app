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
    print(_prefs.getStringList(userId));
    return cartJson.map((json) => Cart.fromJson(jsonDecode(json))).toList();
  }

  Future<void> addToCart(String userId, Cart carts) async {
    print('add trigger');
    List<String> cartItems = _prefs.getStringList(userId) ?? [];
    cartItems.add(jsonEncode(carts.toJson()));
    await _prefs.setStringList(userId, cartItems);
    print(_prefs.getStringList(userId));
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
