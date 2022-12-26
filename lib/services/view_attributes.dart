import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future viewAttribute({required String token, required String name, required String id}) async {
  // product
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/attributes/$id";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse(baseUrl));
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> dataList = jsonDecode(response.body);
  if (streamedResponse.statusCode == 200) {
    log(dataList["attribute"].toString());
    return dataList["attribute"];
  } else {
    return dataList["errors"];
  }
}