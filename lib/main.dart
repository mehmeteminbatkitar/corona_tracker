import 'dart:async';
import 'package:corona_tracker/Screens/AllCountries.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona Tracker',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white, 
      ),
      home: SplashScreen(),
      routes: {
        'home': (context) => AllCountries(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void startTimer() {
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:Text(
          "Corona Tracker",
           style: TextStyle(
                fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
        ),
      ),

    );
  }
}
