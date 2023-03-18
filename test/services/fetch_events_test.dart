import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/services/api_config.dart';
import 'package:mobile_app/services/events_list_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_app/models/event.dart';

import 'fetch_events_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchEvents', () {
    test('returns a list of Events if the http call completes successfully',
        () async {
      final client = MockClient();
      final subject = EventsListService(client: client);

      when(client.get(Uri.parse('${ApiConfig.baseUrl}/events')))
          .thenAnswer((_) async => http.Response('''[{
              "id": 10,
              "freePlace": 2,
              "title": " Short description of Event 1",
              "startTime": 1673034164,
              "endTime": 1683034164,
              "name": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque velit enim, cursus convallis condimentum id, pellentesque at urna. Proin molestie nec lorem vel vulputate. Curabitur vitae justo ut libero scelerisque viverra. Nullam pharetra, est at ultricies dignissim, massa est aliquam erat, in posuere magna purus malesuada ligula. Fusce feugiat aliquam.",
              "placeSchema": "Seralized place schema 1",
              "status": "done",
              "categories": [
                  {
                      "id": 1,
                      "name": "Sport"
                  }
                ]
              }]''', 200));

      expect(await subject.fetchEventsList(), isA<List<Event>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final subject = EventsListService(client: client);

      when(client.get(Uri.parse('${ApiConfig.baseUrl}/events')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(subject.fetchEventsList(), throwsException);
    });
  });
}
