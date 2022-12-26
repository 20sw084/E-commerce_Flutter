import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future createVariableProduct({
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
  required List<dynamic> variations,
}) async {
  // product
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/products/create";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };

  var request = http.MultipartRequest("POST", Uri.parse(baseUrl));
  //add text fields
  Map<String, String>  temp = {
    "name" : name,
    "description" : description,
    "short_description" : shortDescription,
    "product_type" : productType,
    "price" : price,
    "sale_price" : salePrice,
    "status" : status,
    "is_store_featured" : isStoreFeatured,
    "categories" : category,
    "variations" : jsonEncode(variations)
  };
  request.fields.addAll((temp));
  // request.fields["name"] = name;
  // request.fields["description"] = description;
  // request.fields["short_description"] = description;
  // request.fields["product_type"] = productType;
  // request.fields["price"] = price;
  // request.fields["sale_price"] = salePrice;
  // request.fields["status"] = status;
  // request.fields["is_store_featured"] = isStoreFeatured;
  // request.fields["categories"] = category;
  // request.fields["variations"] = jsonEncode(variations);
  //request.files.add(("variants", file));

  if(image != null) {
    var imgField = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(imgField);
  }
  request.headers.addAll(headers);

  print("This is data sent ${request.fields}");
  var response = await request.send();
  if (response.statusCode == 200) {
    /*var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);*/
    return "Product Created!";
  }
  else {
    return null;
  }
}
