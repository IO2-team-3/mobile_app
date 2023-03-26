import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/views/events_browsing/search_view.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile_app/views/events_browsing/event_tile.dart';

class EventsList extends StatefulWidget {
  final APIProvider apiProvider;
  const EventsList({super.key, required this.apiProvider});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchView(
                    categoriesFuture: widget.apiProvider.fetchCategoriesList(),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<Response<BuiltList<Event>>>(
        future: widget.apiProvider.fetchEventsList(),
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
          var eventsList = snapshot.data!.data!;
          return ListView.builder(
            itemCount: eventsList.length,
            itemBuilder: (_, index) {
              return EventTile(
                event: eventsList[index],
              );
            },
          );
        },
      ),
    );
  }
}
