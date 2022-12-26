class AttributesList {
  int id = 0;
  String name = "";
  String type = "";
  int userId = 0;
  int storeId = 0;

  /*"created_at": "2022-12-15T15:37:51.000000Z",
  "updated_at": "2022-12-15T20:46:11.000000Z"*/

  AttributesList(
      {required int id,
      required String name,
      required String type,
      required int userId,
      required int storeId});

  factory AttributesList.fromJson(Map<String, dynamic> json) {
    return AttributesList(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        userId: json["user_id"],
        storeId: json["store_id"]);
  }

  static toJson(AttributesList instance) => {
    "id": instance.id,
    "name": instance.name,
    "type": instance.type,
    "user_id": instance.userId,
    "store_id": instance.storeId,
    /*"created_at": "2022-12-15T15:37:51.000000Z",
    "updated_at": "2022-12-15T20:46:11.000000Z"*/
  };
}
