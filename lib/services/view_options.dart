import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future viewOptions({required String token}) async {
  // TODO: For now attribute & option is hardcoded.
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/attributes/6/options/1";
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
    log(dataList["options"].toString());
    return dataList["options"];
  } else {
    return dataList["errors"];
  }
}