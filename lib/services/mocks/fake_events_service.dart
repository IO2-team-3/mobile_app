import 'package:flutter/services.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_list_service.dart';
import 'package:http/http.dart' as http;

class FakeEventsService implements EventsListService {
  @override
  Future<List<Event>> fetchEventsList() async {
    var json = await rootBundle.loadString('assets/api/events.json');
    var events = Future.delayed(
        const Duration(seconds: 1), () => eventsListFromJson(json));

    return events;
  }

  @override
  http.Client client = http.Client();
}
