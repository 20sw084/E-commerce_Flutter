import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future mystore({required String token}) async {
  // product
  String baseUrl = "https://backend.quickvila.store/api/mystore";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('GET', Uri.parse(baseUrl));
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> data = jsonDecode(response.body);
  if (streamedResponse.statusCode == 200) {
    log(data["mystore"].toString());
    return data["mystore"];
  } else {
    return data["errors"];
  }
}
