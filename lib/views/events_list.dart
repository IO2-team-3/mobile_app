import 'package:flutter/material.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/services/events_service.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

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
    _events = widget.eventsService.fetchEventsList(http.Client());
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
            return const Center(child: CircularProgressIndicator());
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
              subtitle: Text(
                event.name,
                overflow: TextOverflow.ellipsis,
              ),
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

    var startDateStr = DateFormat.yMMMd().format(startDate);
    var endDateStr = DateFormat.yMMMd().format(endDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Reserve'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                event.name,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 22, 180, 207)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Start date: $startDateStr'),
                    )),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 22, 180, 207)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('End date: $endDateStr'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
