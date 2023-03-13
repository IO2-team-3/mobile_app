import 'package:flutter/material.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_service.dart';

class EventsList extends StatefulWidget {
  final EventsService eventsService;
  const EventsList({super.key, required this.eventsService});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late Future<List<Event>> _events;

  @override
  void initState() {
    super.initState();
    _events = widget.eventsService.fetchEventsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: FutureBuilder<List<Event>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return EventTile(
                  event: snapshot.data![index],
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final Event event;
  final icons = const {
    // TODO consult category ids
    1: Icons.sports_football_outlined,
    2: Icons.music_note,
  };

  const EventTile({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                  icons[event.categories[0].id]), // TODO show all categories
              title: Text(event.title),
              subtitle: Text(event.name),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LEARN MORE'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EventDetails(
                            event: event,
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventDetails extends StatelessWidget {
  final Event event;
  const EventDetails({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var startDate = DateTime.fromMillisecondsSinceEpoch(event.startTime * 1000);
    var endDate = DateTime.fromMillisecondsSinceEpoch(event.endTime * 1000);

    var startDateStr = startDate.toString();
    var endDateStr = endDate.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Column(
        children: [
          Text(event.name),
          Text('Start date: $startDateStr'),
          Text('End date: $endDateStr'),
        ],
      ),
    );
  }
}
