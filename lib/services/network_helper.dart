import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper();

  static Future getDataFromApi({
    required String apiEndPoint,
    required dynamic parameter}) async {
    Response response = await get(Uri.parse(apiEndPoint + parameter));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data;
    } else {
      log(response.statusCode.toString());
    }
  }

  static Future zeroParameterApi({required String apiEndPoint}) async {
    Response response = await get(Uri.parse(apiEndPoint));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      return data;
    } else {
      log(response.statusCode.toString());
    }
  }

}
