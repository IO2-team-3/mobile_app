import 'package:flutter/material.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_list_service.dart';

class EventsListProvider extends ChangeNotifier {
  final EventsListService eventsListService;
  EventsListProvider({required this.eventsListService});

  List<Event> _events = [];
  List<Event> get events => _events;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getEventsList() async {
    _isLoading = true;
    notifyListeners();

    _events = await eventsListService.fetchEventsList();
    _isLoading = false;
    notifyListeners();
  }
}
