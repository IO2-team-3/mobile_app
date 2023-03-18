import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/api_config.dart';
import 'package:http/http.dart' as http;

class EventsListService {
  http.Client client;
  EventsListService({required this.client});

  Future<List<Event>> fetchEventsList() async {
    var url = Uri.parse("${ApiConfig.baseUrl}/events");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return eventsListFromJson(response.body);
    } else {
      throw Exception('Failed to fetch events');
    }
  }
}
