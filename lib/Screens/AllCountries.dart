import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:corona_tracker/Screens/Country.dart';
import 'package:corona_tracker/Screens/World.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries = [];
  List filteredCountries = [];
  bool isSearching = false;

  getCountries() async {
    var response = await Dio().get('https://covid19.mathdro.id/api/confirmed');
    return response.data;
  }

  @override
  void initState() {
    getCountries().then((data) {
      setState(() {
        countries = filteredCountries = data;
      });
    });
    super.initState();
    _checkWifi();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = countries
          .where(
            (country) => country['combinedKey']
                .toLowerCase()
                .contains(value.toLowerCase()),
          )
          .toList();
    });
  }

  bool _tryAgain = false;

  _checkWifi() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi);

    if (!connectedToWifi) {
      _showAlert(context);
    }
    if (_tryAgain != !connectedToWifi) {
      setState(() => _tryAgain = !connectedToWifi);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Corona Tracker",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
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
            : Column(children: <Widget>[

                // Search Bar

                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: TextField(
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        _filterCountries(value);
                      },
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Search Country',
                        contentPadding: EdgeInsets.only(
                          top: 14.0,
                          bottom: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                // Search bar end

                // World state button 

                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => World()),
                            );
                          },
                          child: Text("World",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
               // World state button end

             // Country list 
                Flexible(
                    flex: 9,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top:
                                BorderSide(width: 2.0, color: Colors.grey[200]),
                          ),
                          color: Colors.white,
                        ),
                        child: filteredCountries.length > 0
                            ? ListView.builder(
                                itemCount: filteredCountries.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Country(filteredCountries[index]),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 5),
                                        child: Text(
                                          filteredCountries[index]
                                              ['combinedKey'],
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Container(
                                height: MediaQuery.of(context).size.height,
                                color: Colors.white,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          8,
                                    ),
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.red),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    )
                    ),

                  // Country list end  

              ]),
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
