class HomeData {
  List<dynamic> stores = [];
  List<dynamic> featuredProducts = [];
  List<dynamic> topSellingProductsMapList = [];
  // //
  List<dynamic> storesMapList = [];
  List<dynamic> topSellingProducts = [];
  List<dynamic> featuredProductsMapList = [];


  fromJson(Map<String, dynamic> homeData) {
    stores = homeData["stores"];
    topSellingProducts = homeData["top_selling_products"];
    featuredProducts = homeData["featured_products"];
  }

  /*toJson(dynamic instance) {
    Map<String, dynamic> data = {};

    storesMapList = homeData['stores'];
            *//*.forEach((v) {
      return v;
    });*//*
    topSellingProductsMapList = homeData['top_selling_products'];
    featuredProductsMapList = homeData['featured_products'];
    //storesMapList = homeData["featured_products"].map((e) => FeaturedProducts.toJson(e));
    data["stores"] = storesMapList;
    data["top_selling_products"] = topSellingProductsMapList;
    data["featured_products"] = featuredProductsMapList;
    return data;
  }*/
}