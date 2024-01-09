import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app_bloc/models/weather_model.dart';
import 'package:http/http.dart';

class WeatherRepository {
  String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<WeatherModel> getWeather() async {
    try {
      Position location = await _determinePosition();
      return await fetchWeather(location.latitude, location.longitude);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherModel> fetchWeather(final double lat, final double lon) async {
    String appId = dotenv.get('APP_ID');
    final response =
        await get(Uri.parse("$baseUrl?lat=$lat&lon=$lon&appid=$appId"));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
