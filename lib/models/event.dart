import 'dart:convert';

List<Event> eventsListFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventsListToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  Event({
    required this.id,
    required this.freePlace,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.name,
    this.placeSchema,
    required this.status,
    required this.categories,
  });

  final int id;
  final int freePlace;
  final String title;
  final int startTime;
  final int endTime;
  final String name;
  String? placeSchema;
  final String status;
  final List<Category> categories;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        freePlace: json["freePlace"],
        title: json["title"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        name: json["name"],
        placeSchema: json["placeSchema"],
        status: json["status"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "freePlace": freePlace,
        "title": title,
        "startTime": startTime,
        "endTime": endTime,
        "name": name,
        "placeSchema": placeSchema,
        "status": status,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
