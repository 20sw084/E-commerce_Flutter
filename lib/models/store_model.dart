class Stores {
  int? id;
  String? name;
  String? logo;
  String? cover;
  String? description;
  String? url;
  String? address;
  String? latitude;
  String? longitude;
  String? radius;
  String? price;
  String? priceCondition;
  int? manageable;
  int? userId;
  int? productsCount;

  Stores({
    required this.id,
    required this.name,
    required this.address,
    required this.userId,
    required this.cover,
    required this.description,
    required this.logo,
    required this.latitude,
    required this.longitude,
    required this.manageable,
    required this.price,
    required this.priceCondition,
    required this.productsCount,
    required this.radius,
    required this.url
  });

  factory Stores.fromJson(Map<String,dynamic> json) {
    return Stores(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        userId: json["userId"],
        cover: json["cover"],
        description: json["description"],
        logo: json["logo"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        manageable: json["manageable"],
        price: json["price"],
        priceCondition: json["priceCondition"],
        productsCount: json["productsCount"],
        radius: json["radius"],
        url: json["url"]);
  }

  static toJson(Stores instance) => {
  "id" : instance.id,
  "name" : instance.name,
  "address" : instance.address,
  "userId" : instance.userId,
  "cover" : instance.cover,
  "description" : instance.description,
  "logo" : instance.logo,
  "latitude" : instance.latitude,
  "longitude" : instance.longitude,
  "manageable" : instance.manageable,
  "price" : instance.price,
  "priceCondition" : instance.priceCondition,
  "productsCount" : instance.productsCount,
  "radius" : instance.radius,
  "url" : instance.url
  };

  @override
  String toString() {
    return 'Stores{id: $id, name: $name, logo: $logo, cover: $cover, description: $description, url: $url, address: $address, latitude: $latitude, longitude: $longitude, radius: $radius, price: $price, priceCondition: $priceCondition, manageable: $manageable, userId: $userId, productsCount: $productsCount}';
  }
}