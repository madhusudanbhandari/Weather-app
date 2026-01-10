import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
