import 'dart:convert';

List<Order> orderFromMap(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromMap(x)));

String orderToMap(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Order {
  final String id;

  final bool isActive;
  final String price;
  final String company;
  final String picture;
  final String buyer;
  final List<String> tags;
  final Status status;
  final DateTime registered;

  Order({
    required this.id,
    required this.isActive,
    required this.price,
    required this.company,
    required this.picture,
    required this.buyer,
    required this.tags,
    required this.status,
    required this.registered,
  });

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        isActive: json["isActive"],
        price: json["price"],
        company: json["company"],
        picture: json["picture"],
        buyer: json["buyer"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        status: statusValues.map[json["status"]]!,
        registered: DateTime.parse(json["registered"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isActive": isActive,
        "price": price,
        "company": company,
        "picture": picture,
        "buyer": buyer,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "status": statusValues.reverse[status],
        "registered": registered,
      };
}

enum Status { DELIVERED, ORDERED, RETURNED }

final statusValues = EnumValues({"DELIVERED": Status.DELIVERED, "ORDERED": Status.ORDERED, "RETURNED": Status.RETURNED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
