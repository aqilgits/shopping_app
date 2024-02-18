import 'package:shopping_app/Models/items.model.dart';

class Cart {
  final String user;
  final int quantity;
  final Items items;

  Cart({required this.user, required this.quantity, required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      user: json['user'] as String,
      quantity: json['quantity'] as int,
      items: Items.fromJson(json['item']),
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user,
        'quantity': quantity,
        'item': items,
      };
}
