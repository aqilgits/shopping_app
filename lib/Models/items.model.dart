class Items {
  final int id;
  final String title;
  final String description;
  final int price;
  final double discount;
  final dynamic rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List<dynamic> image;

  Items(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discount,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.image});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as int,
        discount: json['discountPercentage'] as double,
        rating: json['rating'] as dynamic,
        stock: json['stock'] as int,
        brand: json['brand'] as String,
        category: json['category'] as String,
        thumbnail: json['thumbnail'] as String,
        image: json['images'] as List<dynamic>);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'discount': discount,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'category': category,
        'thumbnail': thumbnail,
        'image': image
      };
}
