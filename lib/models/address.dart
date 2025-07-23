
class Address {
  final String addressId;
  final String street;
  final String buildingName;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  Address({
    required this.addressId,
    required this.street,
    required this.buildingName,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address (
      addressId: json['addressId'].toString(),
      street: json['street'] ?? '',
      buildingName: json['buildingName'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      zipCode: json['zipCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressId': addressId,
      'street': street,
      'buildingName': buildingName,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
    };
  }
}