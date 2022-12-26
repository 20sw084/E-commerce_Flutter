import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future login({
  required String email,
  required String password,
}) async {
  String baseUrl =
      "https://backend.quickvila.store/api/authenticate?type=store";
  var headers = {'Content-Type': 'application/json; charset=UTF-8'};
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = json.encode({
    "email": email,
    "password": password,
  });
  // request.headers.addAll("Content-Type", "application/json; charset=UTF-8");
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String, dynamic> data = jsonDecode(response.body);
  if (streamedResponse.statusCode == 200) {
    log(data.toString());
    return data;
  } else {
    return data["errors"];
  }
}
