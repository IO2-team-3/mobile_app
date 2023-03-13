import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventWave'),
      ),
      body: const Center(
        child: Text('Nice main page'),
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
