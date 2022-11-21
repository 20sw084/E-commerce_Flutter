import 'dart:convert';
import 'package:http/http.dart' as http;

Future resetPassword({
  required String email,
  required String newPassword,
  required String confirmPassword,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/update";
  var headers = {'Content-Type': 'application/json; charset=UTF-8'};
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = json.encode({
    "email": email,
    "new_password": newPassword,
    "confirm_password": confirmPassword,
  });
  //request.headers.addAll("Content-Type", "application/json; charset=UTF-8");
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String,dynamic> data = jsonDecode(response.body);
  if(streamedResponse.statusCode == 200) {
    return data["message"];
  }
  else {
    return data["errors"];
  }
}
