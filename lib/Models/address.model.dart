class Address {
  String address;
  String city;
  String state;
  String postcode;

  Address(
      {required this.address,
      required this.city,
      required this.state,
      required this.postcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json['address'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        postcode: json['postcode'] as String);
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'city': city,
        'state': state,
        'postcode': postcode,
      };
}
