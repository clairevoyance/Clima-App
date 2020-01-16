import 'dart:ffi';

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '000bd725b9e685e2cacd1383b16d9beb';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey';
    NetworkHelper networkHelper = new NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location l = new Location();
    await l.getCurrentLocation();

    NetworkHelper networkHelper = new NetworkHelper('$openWeatherMapUrl?lat=${l.latitude}&lon=${l.longitude}&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
