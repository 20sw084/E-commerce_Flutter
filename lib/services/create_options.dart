import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future createOptions({required String token, required String name, required dynamic media, required String attrId}) async {
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/attributes/$attrId/options/create";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = jsonEncode({
    "name" : name,
    "media" : media,
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