import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_data.dart';

class WeatherService {
  // Using Open-Meteo API (Free, no key required)
  static const String baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<WeatherData> fetchWeather(String cityName) async {
    // For simplicity, we use hardcoded coordinates for some cities
    double lat, lon;
    switch (cityName.toLowerCase()) {
      case 'hanoi':
        lat = 21.0245;
        lon = 105.8412;
        break;
      case 'ho chi minh':
        lat = 10.7627;
        lon = 106.6602;
        break;
      case 'danang':
        lat = 16.0544;
        lon = 108.2022;
        break;
      default:
        lat = 21.0245;
        lon = 105.8412;
    }

    final url = Uri.parse('$baseUrl?latitude=$lat&longitude=$lon&current_weather=true');
    
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherData.fromJson(data, cityName);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Network error: Check your connection');
    }
  }
}
