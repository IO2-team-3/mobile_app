class ApiConfig {
  static final _apiUrls = {
    'localhost': 'http://10.0.2.2:5000',
    'team1': 'https://dionizos-backend-app.azurewebsites.net/',
    'team2': 'https://biletmajster.azurewebsites.net/', // TODO test when ready
    'team3':
        'http://io2central-env.eba-vfjwqcev.eu-north-1.elasticbeanstalk.com/'
  };
  static String baseUrl = _apiUrls['team3']!;
}
