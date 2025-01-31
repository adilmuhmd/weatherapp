import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:http/http.dart' as http;

class Weatherservice{
  final String BASEURL = "https://api.openweathermap.org/data/2.5/weather";
  final String apikey = "a6920cb083f7613503664bb55f51eefd";

  Weatherservice();

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASEURL?q=$cityName&appid=$apikey&units=metric'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  Future<String>getcurrentcity()async{
     LocationPermission permission = await Geolocator.checkPermission();
     if(permission==LocationPermission.denied){
       permission = await Geolocator.requestPermission();
     }
     Position position = await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.best);

     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
     String? city = placemarks[0].locality;
     return city?? "";
  }



}