import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future updateAttribute(
    {required String token,
      required String name,
      required String id,
      required String type}) async {
  // product
  String baseUrl =
  // TODO to pass atribute id
      "https://backend.quickvila.store/api/mystore/attributes/$id/update";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = jsonEncode({"name": name, "type": type});
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> dataList = jsonDecode(response.body);
  if (streamedResponse.statusCode == 200) {
    log(dataList["message"].toString());
    return dataList["message"];
  } else {
    return dataList["errors"];
  }
}