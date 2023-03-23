import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/services/api_config.dart';
import 'package:mobile_app/views/events_list.dart';
import 'package:mobile_app/views/home_page.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<APIProvider>(
      create: (context) => APIProvider(
        api: Openapi(
            dio: Dio(
              BaseOptions(
                baseUrl: ApiConfig.baseUrl,
              ),
            ),
            serializers: standardSerializers),
      ),
      child: const MainApp(),
    ),
  );
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
        '/events_page': (context) => EventsList(
              apiProvider: context.read<APIProvider>(),
            ),
      },
    );
  }
}
