import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';

class World extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WorldState();
  }
}

class _WorldState extends State<World> {
  final formatter = new NumberFormat("#,###");
  var textSpacing = 0.7;

  var worldConfirmed;
  var worldRecovered;
  var worldDeaths;

  Future getWorldState() async {
    http.Response response = await http.get("https://covid19.mathdro.id/api/");
    var results = jsonDecode(response.body);
    setState(() {
      this.worldConfirmed = results['confirmed']['value'];
      this.worldRecovered = results['recovered']['value'];
      this.worldDeaths = results['deaths']['value'];
    });
  }

  bool _tryAgain = false;

  _checkWifi() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (
        connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi);

    if (!connectedToWifi) {
      _showAlert(context);
    }
    if (_tryAgain != !connectedToWifi) {
      setState(() => _tryAgain = !connectedToWifi);
    }
  }

  @override
  void initState() {
    super.initState();
    this.getWorldState();
    this._checkWifi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "World",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: _tryAgain
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      _checkWifi();
                    }),
              )
            : Container(
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[

                    // Active 
                    Card(
                      elevation: 0,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        child: Column(children: <Widget>[
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Column(children: <Widget>[
                                Text(
                                  "Active",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                    letterSpacing: textSpacing,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  worldConfirmed != null
                                      ? formatter.format(worldConfirmed)
                                      : "Loading",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    
                    // Active end

                    // Recovered
                    
                    Card(
                      elevation: 0,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        child: Column(children: <Widget>[
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Column(children: <Widget>[
                                Text(
                                  "Recovered",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                    letterSpacing: textSpacing,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  worldRecovered != null
                                      ? formatter.format(worldRecovered)
                                      : "Loading",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    
                    // Recovered end

                   
                   // Deaths
                    Card(
                      elevation: 0,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        child: Column(children: <Widget>[
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 40.0),
                              child: Column(children: <Widget>[
                                Text(
                                  "Deaths",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white,
                                    letterSpacing: textSpacing,
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  worldDeaths != null
                                      ? formatter.format(worldDeaths)
                                      : "Loading",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ),
                   // Deaths end

                  ],
                ),
              ),
      ),
    );
  }
 
 // Internet Connection Control 
  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('WARNING'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Please Check the Internet Connection',
                style: TextStyle(
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            color: Colors.red,
            child: Text(
              'Okey',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }
  // Internet Connection Control end
}
