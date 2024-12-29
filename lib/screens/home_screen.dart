import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/forecast_widget.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  String? error;
  WeatherData? currentWeather;
  List<ForecastDay> forecast = [];
  final WeatherService _weatherService = WeatherService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }

      final position = await Geolocator.getCurrentPosition();

      // Fetch weather data
      final weather = await _weatherService.getCurrentWeather(
        position.latitude,
        position.longitude,
      );

      // Fetch forecast data
      final forecastData = await _weatherService.getForecast(
        position.latitude,
        position.longitude,
      );

      setState(() {
        currentWeather = weather;
        forecast = forecastData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _searchCity(String city) async {
    if (city.isEmpty) return;

    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      // Get coordinates for the city
      final coordinates = await _weatherService.getCoordinatesForCity(city);

      // Fetch weather data
      final weather = await _weatherService.getCurrentWeather(
        coordinates['lat']!,
        coordinates['lon']!,
      );

      // Fetch forecast data
      final forecastData = await _weatherService.getForecast(
        coordinates['lat']!,
        coordinates['lon']!,
      );

      setState(() {
        currentWeather = weather;
        forecast = forecastData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search city...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                prefixIcon: Icon(Icons.search,
                    color: Theme.of(context).primaryColor),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear_rounded,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                      )
                    : null,
              ),
              onSubmitted: (value) {
                _searchCity(value);
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(error!),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _getCurrentLocation,
                        child: ListView(
                          children: [
                            if (currentWeather != null)
                              CurrentWeatherWidget(weather: currentWeather!),
                            if (forecast.isNotEmpty)
                              ForecastWidget(forecast: forecast),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
