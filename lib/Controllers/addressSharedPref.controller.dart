import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/Models/address.model.dart';

class AddressSharedPref {
  late SharedPreferences _prefs;

  AddressSharedPref();

  Future<void> init(String userId) async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Address> getCartItem(String userId) {
    List<String> adrJson = _prefs.getStringList(userId) ?? [];
    return adrJson.map((json) => Address.fromJson(jsonDecode(json))).toList();
  }

  Future<void> addToCart(String userId, Address adr) async {
    List<String> adrItems = _prefs.getStringList(userId) ?? [];
    adrItems.add(jsonEncode(adr.toJson()));
    await _prefs.setStringList(userId, adrItems);
  }

  Future<void> removeFromAdr(String userId, Address adr) async {
    final List<String> adrJsonList = _prefs.getStringList(userId) ?? [];
    adrJsonList.remove(jsonEncode(adr.toJson()));
    await _prefs.setStringList(userId, adrJsonList);
  }

  Future<void> clearAdr(String userId) async {
    await init(userId);
    await _prefs.remove(userId);
  }
}
