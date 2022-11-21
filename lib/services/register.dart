import 'dart:convert';
import 'package:http/http.dart' as http;

Future register({
  required String firstName,
  required String lastName,
  required String phoneNumber,
  required String email,
  required String password,
  required String confirmPass,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/register/";
  var headers = {'Content-Type': 'application/json; charset=UTF-8'};
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = json.encode({
    "first_name": firstName,
    "last_name" : lastName,
    "phone" : phoneNumber,
    "email": email,
    "password": password,
    "confirm_password": confirmPass
  });
  //request.headers.addAll("Content-Type", "application/json; charset=UTF-8");
  request.headers.addAll(headers);
  http.StreamedResponse streamedResponse = await request.send();
  var response = await http.Response.fromStream(streamedResponse);
  Map<String,dynamic> data = jsonDecode(response.body);
  if(streamedResponse.statusCode == 200) {
    return data;
  }
  else {
    return data["errors"];
  }
}
