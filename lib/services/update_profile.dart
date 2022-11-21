import 'dart:convert';
import 'package:http/http.dart' as http;

Future updateProfile({
  required String token,
  required String name,
  required String nickName,
  required String address,
  required String dob,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/account/update";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'Bearer $token'
  };
  var request = http.Request('POST', Uri.parse(baseUrl));
  request.body = json.encode({
    "nickname": nickName,
    "dob" : dob,
    "address" : address,
    "name": name,
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
