import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/weather_item.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/widgets/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _citycontroller = TextEditingController();
  final Constants constants = Constants();

  static String API_KEY = "c1967b6f56c2401ba73154020261001";
  String location = "Kathmandu";
  String weatherIcon = 'heavycloudy.png';
  int temperature = 0;
  int humidity = 0;
  int windSpeed = 0;
  int cloudiness = 0;
  String currentDate = "";

  List hourlyweatherForecast = [];
  List dailyweatherForecast = [];
  String currentWeatherStatus = "";

  //api call
  String searchweatherAPI =
      'http://api.weatherapi.com/v1/current.json?key=$API_KEY+&days=7&q=London&aqi=no';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        color: constants.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: size.height * 0.7,
              decoration: BoxDecoration(
                gradient: constants.linearGradientBlue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: constants.primaryColor,
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/menu.png', width: 35),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/pin.png', width: 25),
                          const SizedBox(width: 5),
                          Text(
                            location,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/profile.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 160,
                    child: Image.asset('assets/$weatherIcon'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          temperature.toString(),
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = constants.shader,
                          ),
                        ),
                      ),
                      Text(
                        '°C',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = constants.shader,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    currentWeatherStatus,
                    style: const TextStyle(color: Colors.white10, fontSize: 22),
                  ),
                  Text(
                    currentDate,
                    style: const TextStyle(color: Colors.white10, fontSize: 16),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(color: Colors.white54, thickness: 1),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      // vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                          value: windSpeed.toInt(),
                          unit: 'km/hr',
                          imageUrl: 'assets/windspeed.png',
                        ),
                        WeatherItem(
                          value: humidity.toInt(),
                          unit: '%',
                          imageUrl: 'assets/humidity.png',
                        ),
                        WeatherItem(
                          value: cloudiness.toInt(),
                          unit: '%',
                          imageUrl: 'assets/cloud.png',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
