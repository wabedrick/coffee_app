// import 'package:coffee_app/dashboard.dart';
import 'package:coffee_app/capture_batch.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( const MaterialApp(
    home: CaptureBatch(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(

    );
  }
}