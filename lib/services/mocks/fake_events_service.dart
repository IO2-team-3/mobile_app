import 'package:flutter/services.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_service.dart';
import 'package:http/http.dart' as http;

class FakeEventsService implements EventsService {
  @override
  Future<List<Event>> fetchEventsList(http.Client client) async {
    var json = await rootBundle.loadString('assets/api/events.json');
    var events = Future.delayed(
        const Duration(seconds: 1), () => eventsListFromJson(json));

    return events;
  }
}
