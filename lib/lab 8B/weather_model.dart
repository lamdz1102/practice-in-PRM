class WeatherInfo {
  final String cityName;
  final String country;
  final double latitude;
  final double longitude;
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final int humidity;
  final double precipitation;
  final int weatherCode;

  WeatherInfo({
    required this.cityName,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.precipitation,
    required this.weatherCode,
  });

  factory WeatherInfo.fromJson({
    required Map<String, dynamic> weatherJson,
    required Map<String, dynamic> locationJson,
  }) {
    final current = weatherJson['current'] as Map<String, dynamic>;

    return WeatherInfo(
      cityName: locationJson['name'] as String,
      country: locationJson['country'] as String? ?? '',
      latitude: (locationJson['latitude'] as num).toDouble(),
      longitude: (locationJson['longitude'] as num).toDouble(),
      temperature: (current['temperature_2m'] as num).toDouble(),
      feelsLike: (current['apparent_temperature'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).toInt(),
      precipitation: (current['precipitation'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
    );
  }

  String get description {
    switch (weatherCode) {
      case 0:
        return 'Clear sky';
      case 1:
      case 2:
      case 3:
        return 'Partly cloudy';
      case 45:
      case 48:
        return 'Foggy';
      case 51:
      case 53:
      case 55:
        return 'Drizzle';
      case 61:
      case 63:
      case 65:
        return 'Rainy';
      case 71:
      case 73:
      case 75:
        return 'Snowy';
      case 95:
      case 96:
      case 99:
        return 'Thunderstorm';
      default:
        return 'Unknown weather';
    }
  }

  String get umbrellaRecommendation {
    if (precipitation > 0 || [51, 53, 55, 61, 63, 65, 95, 96, 99].contains(weatherCode)) {
      return 'Take an umbrella';
    }
    return 'No umbrella needed';
  }

  String get activityRecommendation {
    if (temperature >= 35) {
      return 'Too hot for outdoor sports';
    }

    if (temperature <= 15) {
      return 'Cold weather, wear warm clothes';
    }

    if (precipitation > 0) {
      return 'Better to stay indoors';
    }

    return 'Nice weather for a walk';
  }
}