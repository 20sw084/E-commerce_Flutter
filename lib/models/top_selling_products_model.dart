class TopSellingProducts {
  int? id;
  int? productId;
  String? name;
  String? image;
  String? description;
  String? shortDescription;
  String? price;
  String? salePrice;
  String? isFeatured;
  String? productType;
  String? storeId;
  int? manageable;
  String? userId;

  TopSellingProducts(
      {required this.price,
        required this.description,
        required this.userId,
        required this.name,
        required this.id,
        required this.image,
        required this.manageable,
        required this.isFeatured,
        required this.productId,
        required this.productType,
        required this.salePrice,
        required this.shortDescription,
        required this.storeId});

  factory TopSellingProducts.fromJson(Map<String, dynamic> json) {
    return TopSellingProducts(
        price: json["price"],
        description: json["description"],
        userId: json["userId"],
        name: json["name"],
        id: json["id"],
        image: json["image"],
        manageable: json["manageable"],
        isFeatured: json["isFeatured"],
        productId: json["productId"],
        productType: json["productType"],
        salePrice: json["salePrice"],
        shortDescription: json["shortDescription"],
        storeId: json["storeId"]);
  }

  static toJson(TopSellingProducts instance) => {
    "id": instance.id,
    "productId": instance.productId,
    "productType": instance.productType,
    "price": instance.price,
    "description": instance.description,
    "userId": instance.userId,
    "name": instance.name,
    "image": instance.image,
    "manageable": instance.manageable,
    "isFeatured": instance.isFeatured,
    "salePrice": instance.salePrice,
    "shortDescription": instance.shortDescription,
    "storeId": instance.storeId
  };
}