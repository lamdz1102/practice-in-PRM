import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather_model.dart';

class WeatherService {
  final http.Client _client;

  WeatherService({http.Client? client}) : _client = client ?? http.Client();

  Future<WeatherInfo> fetchWeatherByCity(String city) async {
    final location = await _fetchLocation(city);

    final latitude = location['latitude'];
    final longitude = location['longitude'];

    final weatherUrl = Uri.parse(
      'https://api.open-meteo.com/v1/forecast'
          '?latitude=$latitude'
          '&longitude=$longitude'
          '&current=temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m',
    );

    final response = await _client.get(weatherUrl);

    if (response.statusCode != 200) {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }

    final weatherJson = json.decode(response.body) as Map<String, dynamic>;

    if (!weatherJson.containsKey('current')) {
      throw Exception('Unexpected weather response');
    }

    return WeatherInfo.fromJson(
      weatherJson: weatherJson,
      locationJson: location,
    );
  }

  Future<Map<String, dynamic>> _fetchLocation(String city) async {
    final geocodingUrl = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search'
          '?name=${Uri.encodeComponent(city)}'
          '&count=1'
          '&language=en'
          '&format=json',
    );

    final response = await _client.get(geocodingUrl);

    if (response.statusCode != 200) {
      throw Exception('Failed to search city: ${response.statusCode}');
    }

    final jsonMap = json.decode(response.body) as Map<String, dynamic>;

    if (!jsonMap.containsKey('results') || jsonMap['results'] == null) {
      throw Exception('No location found for "$city"');
    }

    final results = jsonMap['results'] as List<dynamic>;

    if (results.isEmpty) {
      throw Exception('No location found for "$city"');
    }

    return results.first as Map<String, dynamic>;
  }

  void dispose() {
    _client.close();
  }
}