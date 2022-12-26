import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future fetchAllVariations(
    {required String token, required List id}) async {
  // product
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/products/get-possible-variations";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  //var request = http.Request('POST', Uri.parse(baseUrl));
  var request = http.MultipartRequest("POST", Uri.parse(baseUrl));
  for (var element in id) {
    request.files.add(http.MultipartFile.fromString('variation_attr', element.toString()));
  }
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> dataList = jsonDecode(response.body);
  if (streamedResponse.statusCode == 200) {
    log("This is Variants List: ${dataList["variants"]}");
    return dataList["variants"];
  } else {
    return dataList["errors"];
  }
}