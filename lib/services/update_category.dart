import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future updateCategory({required String token, required String name, required String id}) async {
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/products/categories/$id/update?name=$name";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('PUT', Uri.parse(baseUrl));
  request.body = jsonEncode({
    "name" : name,
  });
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (streamedResponse.statusCode == 200) {
    Map<String, dynamic> dataList = jsonDecode(response.body);
    log(dataList["message"].toString());
    return dataList["message"];
  } else {
    return null;
  }
}