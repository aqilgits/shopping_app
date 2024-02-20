class User {
  String image;
  String name;
  String token;
  List<String> address;

  User(
      {required this.image,
      required this.name,
      required this.token,
      required this.address});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        image: json['image'] as String,
        name: json['name'] as String,
        token: json['token'] as String,
        address: json['address'] as List<String>);
  }

  Map<String, dynamic> toJson() =>
      {'image': image, 'name': name, 'token': token, 'address': address};
}
