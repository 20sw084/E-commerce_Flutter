class Product {
  int? id;
  String? productId;
  String? name;
  String? image;
  String? description;
  String? short_description;
  String? price;
  String? sale_price;
  String? product_type;
  int? store_id;
  int? manage_able;
  int? user_id;
  String? gallery;
  int? is_site_featured;
  int? is_store_featured;
  String? status;
  int? is_tax_free;
  List? variations;
/*"created_at": "2022-11-21T07:46:02.000000Z",
  "updated_at": "2022-11-21T08:00:03.000000Z",
  "deleted_at": null,*/

  fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productId = json["product_id"];
    name = json["name"];
    image = json["image"];
    description = json["description"];
    short_description = json["short_description"];
    price = json["price"];
    sale_price = json["sale_price"];
    product_type = json["product_type"];
    store_id = json["store_id"];
    manage_able = json["manage_able"];
    user_id = json["user_id"];
    gallery = json["gallery"];
    is_site_featured = json["is_site_featured"];
    is_store_featured = json["is_store_featured"];
    status = json["status"];
    is_tax_free = json["is_tax_free"];
    variations = json["variations"];
  }

  toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "image": image,
        "description": description,
        "short_description": short_description,
        "price": price,
        "sale_price": sale_price,
        "product_type": product_type,
        "store_id": store_id,
        "manage_able": manage_able,
        "user_id": user_id,
        "gallery": gallery,
        "is_site_featured": is_site_featured,
        "is_store_featured": is_store_featured,
        "status": status,
        "is_tax_free": is_tax_free,
        "variations": variations,
/*"created_at": "2022-11-21T07:46:02.000000Z",
        "updated_at": "2022-11-21T08:00:03.000000Z",
        "deleted_at": null,*/
      };
}
