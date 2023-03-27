import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {

  LocationScreen({required this.weather});

  final Weather weather;

  @override
  _LocationScreenState createState() => _LocationScreenState(weather: weather);
}

class _LocationScreenState extends State<LocationScreen> {

  _LocationScreenState({required this.weather});

  Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final newWeather = await OpenWeatherMap.getWeatherData();
                      print(newWeather.cityName);
                      setState(() { 
                        weather = newWeather;
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final String? cityName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));

                      if (cityName == null || cityName == '') { 
                        return; 
                      }

                      final newWeather = await OpenWeatherMap.getWeatherDataInCity(cityName ?? 'null');

                      setState(() {
                        weather = newWeather;
                      });
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${weather.temperature}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '${WeatherModel.getWeatherIcon(weather.weatherID)}',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '${WeatherModel.getMessage(weather.temperature)} in ${weather.cityName}!',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
