import 'package:flutter/material.dart';
import 'package:mobile_app/services/mocks/fake_events_service.dart';
import 'package:mobile_app/views/events_list.dart';
import 'package:mobile_app/views/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/events_page': (context) =>
            EventsList(eventsService: FakeEventsService())
      },
    );
  }
}
