import 'package:flutter/material.dart';
import 'package:mobile_app/models/event.dart';
import 'package:mobile_app/providers/events_list_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<EventsListProvider>().getEventsList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
      ),
      body: Consumer<EventsListProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: value.events.length,
            itemBuilder: (_, index) {
              return EventTile(
                event: value.events[index],
              );
            },
          );
        },
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final Event event;

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
                  child: const Text('RESERVE'),
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
            Wrap(
              spacing: 5,
              children: List.generate(event.categories.length, (index) {
                return Chip(
                  label: Text(
                    event.categories[index].name,
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.amber,
                );
              }),
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

    var startDateStrYMMD = DateFormat.yMMMd().format(startDate);
    var startDateStrHM = DateFormat.jm().format(startDate);
    var endDateStrYMMD = DateFormat.yMMMd().format(endDate);
    var endDateStrHM = DateFormat.jm().format(endDate);

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
                    child: Column(
                      children: [
                        Text('Start date: $startDateStrYMMD'),
                        Text(startDateStrHM),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 22, 180, 207)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('End date: $endDateStrYMMD'),
                        Text(endDateStrHM),
                      ],
                    ),
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
