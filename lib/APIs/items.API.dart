import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/Models/items.model.dart';

List<Items> parseItems(String responseBody) {
  final parsed = json.decode(responseBody)['products'];
  return parsed.map<Items>((json) => Items.fromJson(json)).toList();
  // return parsed.map<Items>((json) => Items.fromJson(json)).toList();
}

Future<List<Items>> getItems() async {
  var url = Uri.parse('https://dummyjson.com/products');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return parseItems(response.body);
  } else {
    throw Exception('Unable to fetch the items from API');
  }
}
