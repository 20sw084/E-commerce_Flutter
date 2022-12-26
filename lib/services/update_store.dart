import 'dart:io';
import 'package:http/http.dart' as http;

updateStore({
  required String token,
  required String name,
  required String description,
  required String url,
  required String address,
  required int latitude,
  required int longitude,
  required List categories,
  required File logo,
  required File cover,
}) async {
  String baseUrl = "https://backend.quickvila.store/api/mystore/update";
  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token'
  };
  var request = http.MultipartRequest("POST", Uri.parse(baseUrl));
  //add text fields
  request.fields["name"] = name;
  request.fields["description"] = description;
  request.fields["url"] = url;
  request.fields["address"] = address;
  request.fields["latitude"] = latitude.toString();
  request.fields["longitude"] = longitude.toString();
  //create multipart using filepath, string or bytes
  var logos = await http.MultipartFile.fromPath("logo", logo.path);
  var covers = await http.MultipartFile.fromPath("cover", cover.path);
  //add multipart to request
  request.files.add(logos);
  request.files.add(covers);
  request.headers.addAll(headers);
  var response = await request.send();
  if (response.statusCode == 200) {
    /*var responseData = await response.stream.toBytes();
    // var responseString = String.fromCharCodes(responseData);*/
    return "Store Updated!";
  }
  else {
    return null;
  }
}