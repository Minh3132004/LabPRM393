class WeatherData {
  final double temperature;
  final int weatherCode;
  final double windSpeed;
  final String city;

  WeatherData({
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
    required this.city,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, String city) {
    final current = json['current_weather'];
    return WeatherData(
      temperature: current['temperature'],
      weatherCode: current['weathercode'],
      windSpeed: current['windspeed'],
      city: city,
    );
  }

  String get weatherDescription {
    switch (weatherCode) {
      case 0: return 'Clear sky';
      case 1: case 2: case 3: return 'Mainly clear, partly cloudy, and overcast';
      case 45: case 48: return 'Fog and depositing rime fog';
      case 51: case 53: case 55: return 'Drizzle: Light, moderate, and dense intensity';
      case 61: case 63: case 65: return 'Rain: Slight, moderate and heavy intensity';
      case 71: case 73: case 75: return 'Snow fall: Slight, moderate, and heavy intensity';
      case 95: return 'Thunderstorm: Slight or moderate';
      default: return 'Unknown weather';
    }
  }

  String get recommendation {
    if (weatherCode >= 51 && weatherCode <= 65) {
      return 'Do I need an umbrella? YES! It is raining.';
    } else if (weatherCode == 95) {
      return 'Stay indoors! Thunderstorm detected.';
    } else if (temperature > 35) {
      return 'It is very hot. Stay hydrated and avoid outdoor sports.';
    } else if (temperature < 15) {
      return 'It is cold. Wear a jacket.';
    } else if (weatherCode >= 0 && weatherCode <= 3) {
      return 'Perfect day for a walk or outdoor activities!';
    }
    return 'Have a great day!';
  }
}
