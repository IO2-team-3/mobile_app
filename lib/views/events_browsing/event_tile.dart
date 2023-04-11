import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

import 'event_details.dart';

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
