import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/weather_item.dart';
import 'package:flutter_application_1/ui/home_page.dart';
import 'package:flutter_application_1/widgets/constants.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final dailyForecastWeather;

  const DetailPage({Key? key, this.dailyForecastWeather}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final Constants _constants = Constants();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(title: const Text("Forecast"), centerTitle: true),
    );
  }
}
