class ItemController {
  double calcDiscount(int price, dynamic discount) {
    double total;
    total = discount / 100 * price;
    total = price - total;
    return double.parse(total.toStringAsFixed(2));
  }
}
