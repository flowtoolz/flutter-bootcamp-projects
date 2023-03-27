import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/services/location.dart';

class OpenWeatherMap {
static Future<Weather> getWeatherDataInCity(String city) async {
    String uriString = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_apiKey';

    http.Response response = await http.get(Uri.parse(uriString));
    
    if (response.statusCode == 200) {
      dynamic responseJSON = jsonDecode(response.body);
      
      return Weather(
        weatherID: responseJSON['weather'][0]['id'], 
        cityName: responseJSON['name'],
        temperature: responseJSON['main']['temp'],
      );
    } else {
      final statusCode = response.statusCode;
      throw 'error: status code $statusCode';
    }
  }

  static Future<Weather> getWeatherData() async {
    final pos = await LocationService.getGeoLocation();

    String uriString = 'https://api.openweathermap.org/data/2.5/weather?lat=${pos.latitude}&lon=${pos.longitude}&units=metric&appid=$_apiKey';

    http.Response response = await http.get(Uri.parse(uriString));
    
    if (response.statusCode == 200) {
      dynamic responseJSON = jsonDecode(response.body);
      
      return Weather(
        weatherID: responseJSON['weather'][0]['id'], 
        cityName: responseJSON['name'],
        temperature: responseJSON['main']['temp'],
      );
    } else {
      final statusCode = response.statusCode;
      throw 'error: status code $statusCode';
    }
  }

  static const _apiKey = 'a2ccbc778d480c9235f58efcd4463ab6';
}

