import 'dart:io';
import 'package:http/http.dart' as http;

Future updateVariableProduct({
  required String productId,
  required String token,
  required String name,
  required String description,
  required String shortDescription,
  required String productType,
  required String price,
  required String salePrice,
  required String status,
  required String isStoreFeatured,
  required File? image,
  required String category,
  required String variationName,
  required String variationPrice,
  required String variationSalePrice,
  required Map<String, dynamic> variant,
}) async {
  // product
  // TODO: product id is hardcoded here
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/products/$productId/update";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.MultipartRequest("POST", Uri.parse(baseUrl));
  //add text fields
  request.fields["name"] = name;
  request.fields["description"] = description;
  request.fields["short_description"] = description;
  request.fields["product_type"] = productType;
  request.fields["price"] = price;
  request.fields["sale_price"] = salePrice;
  request.fields["status"] = status;
  request.fields["is_store_featured"] = isStoreFeatured;
  request.fields["categories"] = category;
  request.fields["variations[0][name]"] = variationName;
  request.fields["variations[0][price]"] = variationPrice;
  request.fields["variations[0][sale_price]"] = variationSalePrice;
  //request.fields["variations[0][variant]"] = variant;

  if (image != null) {
    var imgField = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(imgField);
  }

  request.headers.addAll(headers);
  var response = await request.send();
  if (response.statusCode == 200) {
    return "Product Updated!";
  } else {
    return null;
  }
}
