import 'package:flutter/material.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/service/weatherservice.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';


class weatherPage extends StatefulWidget {
  const weatherPage({super.key});

  @override
  State<weatherPage> createState() => _weatherPageState();
}

class _weatherPageState extends State<weatherPage> {


  final weatherservice = Weatherservice();
  Weather? _weather;
  void _fetchWeather() async {
    String cityName = await weatherservice.getcurrentcity();

    try{
      final weather = await weatherservice.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    }

    catch(e){
      print(e);
    }
  }
  void searchcity(String nm) async {
    String cityName = nm;

    try{
      final weather = await weatherservice.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    }

    catch(e){
      print(e);
    }
  }




  String weatherimage(String? icon){
    if(icon == null) return '';

    switch(icon){
      case "01d":
        return "images/sun.png";
      case "01n":
        return "images/night.png";
      case "02d":
        return "images/fewclouds.png";
      case "02n":
        return "images/fewcloudsn.png";
      case "03d":
        return "images/clouds.png";
      case "03n":
        return "images/clouds.png";
      case "04d":
        return "images/brokenclouds.png";
      case "04n":
        return "images/brokenclouds.png";
      case "09d":
        return "images/showerain.png";
      case "09n":
        return "images/showerain.png";
      case "10d":
        return "images/rain.png";
      case "10n":
        return "images/rainn.png";
      case "11d":
        return "images/thunderstorm.png";
      case "11n":
        return "images/thunderstormn.png";
      case "13d":
        return "images/snow.png";
      case "13n":
        return "images/snow.png";
      case "50d":
        return "images/mist.png";
      case "50n":
        return "images/mistn.png";
      default:
        return "images/sun.png";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }



  var size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: Center(
        child: _weather == null
            ? CircularProgressIndicator()
            : SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                _weather?.name ?? "",
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: "Gotham",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                _weather?.main ?? "",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "Gotham",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: height / 6,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(weatherimage(_weather?.icon)),
                  ),
                ),
              ),
              Text(
                "${_weather?.temp != null ? _weather!.temp.round().toString() + '\u00B0C' : ''}",
                style: const TextStyle(
                  fontSize: 90,
                  fontFamily: "Gotham",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${_weather?.feels_like != null ? 'Feels Like ' + _weather!.feels_like.round().toString() + '\u00B0C' : ''}",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Gotham",
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_weather?.temp_min != null ? 'Min ' + _weather!.temp_min.round().toString() + '\u00B0C' : ''}",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gotham",
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    "${_weather?.temp_max != null ? 'Max ' + _weather!.temp_max.round().toString() + '\u00B0C' : ''}",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gotham",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: height / 30,
                          left: width / 20.9,
                          child: SvgPicture.asset("icons/windicon.svg",
                              color: Theme.of(context).colorScheme.onPrimary, height: 25),
                        ),
                        Positioned(
                          top: height / 30,
                          left: width / 5.9,
                          child: Text(
                            "Wind",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 15,
                              fontFamily: "Gotham",
                            ),
                          ),
                        ),
                        Positioned(
                          top: height / 10,
                          left: width / 13.9,
                          child: Text(
                            "${_weather?.speed.toString()} MPH",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 25,
                              fontFamily: "Gotham",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: height / 30,
                          left: width / 20.9,
                          child: SvgPicture.asset("icons/humidity.svg",
                              color: Theme.of(context).colorScheme.onPrimary, height: 25),
                        ),
                        Positioned(
                          top: height / 30,
                          left: width / 6.9,
                          child: Text(
                            "Humidity",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 15,
                              fontFamily: "Gotham",
                            ),
                          ),
                        ),
                        Positioned(
                          top: height / 10,
                          left: width / 8.9,
                          child: Text(
                            "${_weather?.humidity.round()} %",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 35,
                              fontFamily: "Gotham",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(
                    width: width / 1.5,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          searchcity(value);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Enter City Name",
                        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                        prefixIcon: Icon(Icons.location_city, color: Theme.of(context).colorScheme.primary),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: _fetchWeather,
                    child: const Icon(Icons.location_on_outlined, size: 35),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
