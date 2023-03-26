import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

import 'event_tile.dart';

class FilteredEventList extends StatefulWidget {
  final APIProvider apiProvider;
  const FilteredEventList({super.key, required this.apiProvider});

  @override
  State<FilteredEventList> createState() => _FilteredEventListState();
}

class _FilteredEventListState extends State<FilteredEventList> {
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
        future: _fetchEvents(
          widget.apiProvider,
          Provider.of<SearchQueryProvider>(context),
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
          var filteredEvents = _filterEvents(
              eventsList, Provider.of<SearchQueryProvider>(context));
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

  List<Event> _filterEvents(List<Event> events, SearchQueryProvider query) {
    bool distanceSpecified = query.distanceInKm != null;
    var filtered = events
        .where((event) => event.title!.contains(query.eventName))
        .where((event) {
      if (!distanceSpecified) {
        return true;
      }
      final distanceInMeters = GeolocatorPlatform.instance.distanceBetween(
        query.currentLocation!.latitude,
        query.currentLocation!.longitude,
        double.parse(event.latitude!),
        double.parse(event.longitude!),
      );
      if (distanceInMeters / 1000 < query.distanceInKm!) {
        return true;
      }
      return false;
    });

    return filtered.toList();
  }

  Future<List<Event>> _fetchEvents(
      APIProvider apiProvider, SearchQueryProvider queryProvider) async {
    var response = await apiProvider.fetchEventsList();
    var allEvents = response.data!.toList();
    if (queryProvider.categories.isEmpty) {
      return allEvents;
    }

    Set<Event> eventsWithDesiredCategories = {};
    for (var category in queryProvider.categories) {
      var eventsWithCurrentCatgoryResponse =
          await apiProvider.fetchEventByCategoryId(categoryId: category.id!);
      var eventsWithCurrentCategory =
          eventsWithCurrentCatgoryResponse.data!.asList();
      for (var event in eventsWithCurrentCategory) {
        eventsWithDesiredCategories.add(event);
      }
    }

    return eventsWithDesiredCategories.toList();
  }
}
