import 'package:flutter/material.dart';
import 'package:mobile_app/views/home_page/carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EventWave'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/layout/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Carousel(),
            ),
            Flexible(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Creating events, organizing business meetings, throwing parties are all at your fingertips!",
                    style: TextStyle(
                        color: Color.fromARGB(255, 22, 180, 207), fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
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
          DrawerHeader(
            child: SizedBox(
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('assets/img/logo/full.png'),
            ),
          ),
          ListTile(
            title: const Text('Events'),
            onTap: () {
              Navigator.pushNamed(context, '/events_page');
            },
          ),
          ListTile(
            title: const Text('My reservations'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
