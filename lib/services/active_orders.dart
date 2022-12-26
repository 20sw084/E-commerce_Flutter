import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future activeOrders({
  required String token,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/mystore/active-orders";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  /*dynamic response = http.get(Uri.parse(baseUrl),
    headers: headers,
  );*/
  var request = http.Request('GET', Uri.parse(baseUrl));
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    log("This is orders List: ${data["orders"]}");
    return data["orders"];
  } else {
    return null;
  }
}
