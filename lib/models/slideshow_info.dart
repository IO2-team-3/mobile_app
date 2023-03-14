import 'dart:convert';

class SlideshowInfo {
  late String id;
  late String photo;
  late String text;

  SlideshowInfo({required this.id, required this.photo, required this.text});

  SlideshowInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['photo'] = photo;
    data['text'] = text;
    return data;
  }
}

List<SlideshowInfo> slideShowInfoListFromJson(String str) =>
    List<SlideshowInfo>.from(
        json.decode(str).map((x) => SlideshowInfo.fromJson(x)));
