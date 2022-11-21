

import 'package:tri_karo_2/models/featured_products_model.dart';
import 'package:tri_karo_2/models/store_model.dart';
import 'package:tri_karo_2/models/top_selling_products_model.dart';
import 'package:tri_karo_2/services/network_helper.dart';

Future getHomeDetails() async {
 dynamic dataList = await NetworkHelper.zeroParameterApi(apiEndPoint: "https://backend.quickvila.store/api/home");

 // This function will return 3 lists of model objects respectively, which will be called
 // in home FromJson
 List<dynamic> stores = dataList["stores"].map((e) {
  return Stores.fromJson(e);
 }).toList();
 List<dynamic> storesList = stores.map((item) => Stores.toJson(item)).toList();
 List<dynamic> topSellingProducts = dataList["top_selling_products"].map((e) {
  return TopSellingProducts.fromJson(e);
 }).toList();
 List<dynamic> topSellingProductsList = topSellingProducts.map((item) => TopSellingProducts.toJson(item)).toList();
 List<dynamic> featuredProducts = dataList["featured_products"].map((e) {
  return FeaturedProducts.fromJson(e);
 }).toList();
 List<dynamic> featuredProductsList = featuredProducts.map((item) => FeaturedProducts.toJson(item)).toList();
 Map<String, dynamic> homeData = {
  "stores" : storesList,
  "featured_products" : featuredProductsList,
  "top_selling_products" : topSellingProductsList
 };
 return homeData;
}