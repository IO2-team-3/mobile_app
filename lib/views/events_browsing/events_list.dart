import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:openapi/openapi.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile_app/views/events_browsing/event_tile.dart';
import 'package:provider/provider.dart';

import 'filtering/search_view.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
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
        title: const Text('Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchView(),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<Response<BuiltList<Event>>>(
        future: futureEvents,
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
          var eventsList = _getInFutureEvents(snapshot.data!.data!);
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

  List<Event> _getInFutureEvents(BuiltList<Event> events) {
    var filtered =
        events.where((event) => event.status == EventStatus.inFuture);
    return filtered.toList();
  }
}
