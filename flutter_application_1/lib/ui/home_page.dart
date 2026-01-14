import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/weather_item.dart';
import 'package:flutter_application_1/ui/detail_page.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/widgets/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchWeatherData(location);
  }

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

  String buildWeatherAPI(String city) {
    return 'http://api.weatherapi.com/v1/forecast.json?key=$API_KEY&days=7&q=$city&aqi=no';
  }

  void fetchWeatherData(String searchText) async {
    try {
      final url = buildWeatherAPI(searchText);
      final searchResult = await http.get(Uri.parse(url));

      if (searchResult.statusCode == 200) {
        final weatherData = json.decode(searchResult.body);

        var locationData = weatherData['location'];
        var currentWeather = weatherData['current'];

        setState(() {
          location = getShortLocationName(locationData['name']);

          var parsedDate = DateTime.parse(
            locationData['localtime'].substring(0, 10),
          );
          currentDate = DateFormat(' dd MMMM yyyy').format(parsedDate);

          currentWeatherStatus = currentWeather['condition']['text'];

          currentWeatherStatus.replaceAll(' ', '').toLowerCase() + ".png";
          temperature = currentWeather['temp_c'].toInt();
          humidity = currentWeather['humidity'].toInt();
          windSpeed = currentWeather['wind_kph'].toInt();
          cloudiness = currentWeather['cloud'].toInt();

          dailyweatherForecast = weatherData['forecast']['forecastday'];
          hourlyweatherForecast = dailyweatherForecast[0]['hour'];
        });
      } else {
        print(
          "Failed to fetch weather data. Status code: ${searchResult.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching weather data: $e");
    }
  }

  static String getShortLocationName(String s) {
    List<String> wordList = s.split(' ');

    if (wordList.isNotEmpty) {
      if (wordList.length > 1) {
        return wordList[0] + wordList[1];
      } else {
        return wordList[0];
      }
    } else {
      return " ";
    }
  }

  String getWeatherAsset(String condition) {
    // Normalize the API response
    final text = condition.toLowerCase().trim();

    if (text.contains('sunny')) return 'sunny.png';
    if (text.contains('clear')) return 'clear.png';
    if (text.contains('partly')) return 'partlycloudy.png';
    if (text.contains('cloud')) return 'cloudy.png';
    if (text.contains('overcast')) return 'overcast.png';

    if (text.contains('mist')) return 'mist.png';
    if (text.contains('fog')) return 'fog.png';

    if (text.contains('rain')) return 'rain.png';
    if (text.contains('snow')) return 'snow.png';
    if (text.contains('sleet')) return 'sleet.png';

    if (text.contains('thunder')) return 'thunder.png';

    // fallback icon if nothing matches
    return 'unknown.png';
  }

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
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
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
                      children: [
                        Image.asset('assets/menu.png', width: 35),
                        Row(
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
                              onPressed: () {
                                _citycontroller.clear();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.4,
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Search City',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          TextField(
                                            controller: _citycontroller,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Enter city name',
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              fetchWeatherData(
                                                _citycontroller.text,
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: Text('Search'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          temperature.toString(),
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()..shader = constants.shader,
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
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      currentDate,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(color: Colors.white54),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherItem(
                          value: windSpeed,
                          unit: 'km/hr',
                          imageUrl: 'assets/windspeed.png',
                        ),
                        WeatherItem(
                          value: humidity,
                          unit: '%',
                          imageUrl: 'assets/humidity.png',
                        ),
                        WeatherItem(
                          value: cloudiness,
                          unit: '%',
                          imageUrl: 'assets/cloud.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  dailyForecastWeather: dailyweatherForecast,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Forecast',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 115,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: hourlyweatherForecast.length,
                        itemBuilder: (context, index) {
                          final hour = hourlyweatherForecast[index];

                          final time = hour['time'].toString().substring(
                            11,
                            16,
                          );
                          final temp = hour['temp_c'].toInt();
                          final condition = hour['condition']['text'];

                          final iconAsset = getWeatherAsset(condition);

                          return Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 15),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  time,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),

                                Image.asset(
                                  'assets/$iconAsset',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.contain,
                                ),

                                Text(
                                  '$temp°',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
