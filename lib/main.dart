import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/providers/api_provider.dart';
import 'package:mobile_app/providers/categories_cache_provider.dart';
import 'package:mobile_app/providers/events_cache_provider.dart';
import 'package:mobile_app/providers/search_query_provider.dart';
import 'package:mobile_app/services/api_config.dart';
import 'package:mobile_app/views/events_browsing/events_list.dart';
import 'package:mobile_app/views/events_browsing/filtering/filtered_events_list.dart';
import 'package:mobile_app/views/home_page/home_page.dart';
import 'package:openapi/openapi.dart';
import 'package:provider/provider.dart';

void main() {
  final APIProvider apiProvider = APIProvider(
    api: Openapi(
      dio: Dio(BaseOptions(baseUrl: ApiConfig.baseUrl)),
      serializers: standardSerializers,
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<APIProvider>(
          create: (context) => apiProvider,
        ),
        ChangeNotifierProvider<SearchQueryProvider>(
          create: (context) => SearchQueryProvider(),
        ),
        ChangeNotifierProvider<EventsCacheProvider>(
          create: (context) => EventsCacheProvider(apiProvider: apiProvider),
        ),
        ChangeNotifierProvider<CategoriesCacheProvider>(
          create: (context) =>
              CategoriesCacheProvider(apiProvider: apiProvider),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventWave',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/events_page': (context) => const EventsList(),
        '/events_page/filtered': (context) => const FilteredEventList(),
      },
    );
  }
}
