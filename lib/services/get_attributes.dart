import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAttributesFromApi({required String token}) async {
  // product
  String baseUrl =
      "https://backend.quickvila.store/api/mystore/attributes";
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
    /*dynamic attributesList = dataList["attributes"].map((val) {
      return AttributesList.fromJson(val);
    });*/
    return dataList["attributes"];
  } else {
    return null;
  }
}