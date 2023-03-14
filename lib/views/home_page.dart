import 'package:flutter/material.dart';
import 'package:mobile_app/services/slideshow_service.dart';
import 'package:mobile_app/views/carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventWave'),
      ),
      body: Carousel(
        slideshowService: SlideshowService(),
      ),
      drawer: const AppMenu(),
    );
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('drawer header'),
          ),
          ListTile(
            title: const Text('Events'),
            onTap: () {
              Navigator.pushNamed(context, '/events_page');
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
