import 'dart:convert';

import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/api_config.dart';
import 'package:http/http.dart' as http;

class EventsService {
  Future<List<Event>> fetchEventsList() async {
    var url = Uri.parse("${ApiConfig.baseUrl}/posts");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return eventFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch events');
    }
  }
}
