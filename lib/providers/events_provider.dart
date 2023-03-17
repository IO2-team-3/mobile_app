import 'package:flutter/material.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_service.dart';

// unused
// class EventsProvider extends ChangeNotifier {
//   final EventsService eventsService;
//   List<Event>? _eventsList;
//   bool _areEventsAvailable = false;

//   EventsProvider({required this.eventsService});

//   bool get areEventsAvailable => _areEventsAvailable;
//   List<Event>? get eventsList => _eventsList;

//   void fetchEventsAction() {
//     _commitEventsListStatus(false);
//     eventsService.fetchEventsList().then((value) {
//       _commitEventsList(value);
//       _commitEventsListStatus(true);
//     });
//   }

//   void _commitEventsList(List<Event> events) {
//     _eventsList = events;
//     notifyListeners();
//   }

//   void _commitEventsListStatus(bool areEventsAvailable) {
//     _areEventsAvailable = areEventsAvailable;
//     notifyListeners();
//   }
// }
