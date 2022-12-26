import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future getCategoriesFromApi({required String token}) async {
  // product
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/products/categories";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse(baseUrl));
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (streamedResponse.statusCode == 200) {
    Map<String, dynamic> dataList = jsonDecode(response.body);
    return dataList["categories"];
  } else {
    return null;
  }
}