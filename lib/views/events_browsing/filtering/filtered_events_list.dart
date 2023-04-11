import 'dart:collection';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import '../event_tile.dart';

class FilteredEventList extends StatefulWidget {
  const FilteredEventList({super.key});

  @override
  State<FilteredEventList> createState() => _FilteredEventListState();
}

class _FilteredEventListState extends State<FilteredEventList> {
  late Future<Response<BuiltList<Event>>> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = context.read<EventsCacheProvider>().getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtered events'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<SearchQueryProvider>(context, listen: false)
                .resetSearchQuery();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<List<Event>>(
        future: fetchEventsWithDesiredCategories(
          Provider.of<APIProvider>(context, listen: false),
          Provider.of<SearchQueryProvider>(context).categories,
          futureEvents,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Connection error!'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var eventsList = snapshot.data!;
          var filteredEvents = filterEvents(eventsList,
              Provider.of<SearchQueryProvider>(context, listen: false));
          return ListView.builder(
            itemCount: filteredEvents.length,
            itemBuilder: (_, index) {
              return EventTile(
                event: filteredEvents[index],
              );
            },
          );
        },
      ),
    );
  }
}

List<Event> filterEvents(List<Event> events, SearchQueryProvider query) {
  bool distanceSpecified = query.distanceInKm != null;
  var filtered = events
      .where((event) =>
          event.title.toLowerCase().contains(query.eventName.toLowerCase()) ||
          event.name.toLowerCase().contains(query.eventName.toLowerCase()))
      .where((event) {
    if (!distanceSpecified) {
      return true;
    }
    final distanceInMeters = GeolocatorPlatform.instance.distanceBetween(
      query.currentLocation!.latitude,
      query.currentLocation!.longitude,
      double.parse(event.latitude),
      double.parse(event.longitude),
    );
    if (distanceInMeters / 1000 < query.distanceInKm!) {
      return true;
    }
    return false;
  });

  return filtered.toList();
}

Future<List<Event>> fetchEventsWithDesiredCategories(
    APIProvider apiProvider,
    UnmodifiableListView<Category> desiredCategories,
    Future<Response<BuiltList<Event>>> futureEvents) async {
  var response = await futureEvents;
  var allEvents = response.data!.toList();
  if (desiredCategories.isEmpty) {
    return allEvents;
  }

  List<Event> eventsWithDesiredCategories = [];
  for (var category in desiredCategories) {
    var eventsWithCurrentCatgoryResponse =
        await apiProvider.fetchEventByCategoryId(categoryId: category.id);
    var eventsWithCurrentCategory =
        eventsWithCurrentCatgoryResponse.data!.asList();
    for (var event in eventsWithCurrentCategory) {
      bool isAlreadyInList =
          eventsWithDesiredCategories.any((e) => e.id == event.id);
      if (isAlreadyInList) {
        continue;
      }
      eventsWithDesiredCategories.add(event);
    }
  }

  return eventsWithDesiredCategories.toList();
}
