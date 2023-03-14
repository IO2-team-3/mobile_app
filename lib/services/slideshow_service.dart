import 'package:flutter/services.dart';
import 'package:mobile_app/models/slideshow_info.dart';

class SlideshowService {
  Future<List<SlideshowInfo>> fetchSlideshowInfosList() async {
    var path = 'assets/img/slideshow/slideshow.json';
    final data = await rootBundle.loadString(path);
    return slideShowInfoListFromJson(data);
  }
}
