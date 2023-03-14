import 'package:flutter/services.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_service.dart';

class FakeEventsService implements EventsService {
  @override
  Future<List<Event>> fetchEventsList() async {
    var json = await rootBundle.loadString('assets/api/events.json');
    var events =
        Future.delayed(const Duration(seconds: 1), () => eventFromJson(json));

    return events;
  }
}
