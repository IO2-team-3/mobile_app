class ApiConfig {
  static final _apiUrls = {
    'localhost': 'http://10.0.2.2:5000',
    'team1': 'https://dionizos-backend-app.azurewebsites.net/',
    'team2': 'https://biletmajster.azurewebsites.net/',
    'team3':
        'http://io2central-env.eba-vfjwqcev.eu-north-1.elasticbeanstalk.com/'
  };
  static const defaultServer = 'team3';

  static Map<String, String> get apiUrls => _apiUrls;
  static String _server = defaultServer;
  static String get server => _server;
  static set server(String? value) {
    if (value != null) {
      _server = value;
    }
  }

  static String get baseUrl => _apiUrls[_server] ?? _apiUrls[defaultServer]!;

  static const s3url =
      ''; //'https://io2-central-photos.s3.amazonaws.com/'; // unused
}
