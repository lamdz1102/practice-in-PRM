import 'package:flutter/material.dart';

import 'weather_model.dart';
import 'weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController(
    text: 'Ho Chi Minh',
  );

  late Future<WeatherInfo> _futureWeather;

  @override
  void initState() {
    super.initState();
    _futureWeather = _weatherService.fetchWeatherByCity(_cityController.text);
  }

  void _searchWeather() {
    final city = _cityController.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a city name'),
        ),
      );
      return;
    }

    setState(() {
      _futureWeather = _weatherService.fetchWeatherByCity(city);
    });
  }

  void _retry() {
    setState(() {
      _futureWeather = _weatherService.fetchWeatherByCity(
        _cityController.text.trim(),
      );
    });
  }

  @override
  void dispose() {
    _cityController.dispose();
    _weatherService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Companion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchBar(),

            const SizedBox(height: 16),

            Expanded(
              child: FutureBuilder<WeatherInfo>(
                future: _futureWeather,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingState();
                  }

                  if (snapshot.hasError) {
                    return _buildErrorState(snapshot.error.toString());
                  }

                  if (!snapshot.hasData) {
                    return _buildEmptyState();
                  }

                  return _buildWeatherContent(snapshot.data!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _cityController,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              labelText: 'City name',
              hintText: 'Example: Hanoi, Tokyo, London',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_city),
            ),
            onSubmitted: (_) => _searchWeather(),
          ),
        ),

        const SizedBox(width: 8),

        FilledButton(
          onPressed: _searchWeather,
          child: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
              ),

              const SizedBox(height: 12),

              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              const SizedBox(height: 8),

              Text(
                message,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text('No weather data'),
    );
  }

  Widget _buildWeatherContent(WeatherInfo weather) {
    return ListView(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  '${weather.cityName}, ${weather.country}',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  weather.description,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 20),

                Text(
                  '${weather.temperature.toStringAsFixed(1)}°C',
                  style: Theme.of(context).textTheme.displayMedium,
                ),

                const SizedBox(height: 8),

                Text(
                  'Feels like ${weather.feelsLike.toStringAsFixed(1)}°C',
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.water_drop,
                title: 'Humidity',
                value: '${weather.humidity}%',
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _InfoCard(
                icon: Icons.air,
                title: 'Wind',
                value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _InfoCard(
          icon: Icons.umbrella,
          title: 'Umbrella Recommendation',
          value: weather.umbrellaRecommendation,
        ),

        const SizedBox(height: 12),

        _InfoCard(
          icon: Icons.directions_walk,
          title: 'Activity Recommendation',
          value: weather.activityRecommendation,
        ),

        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Purpose-driven decision'),
            subtitle: Text(
              'Based on temperature, precipitation, and weather condition, '
                  'the app suggests whether the user should bring an umbrella '
                  'or go outside for activities.',
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}