import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future orderRefunds({
  required String token,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/mystore/active-orders/1/refund";
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
    log("This is refunds List: ${data["message"]}");
    return data["message"];
  } else {
    return null;
  }
}
