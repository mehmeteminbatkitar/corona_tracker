import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Country extends StatelessWidget {
  final Map country;
  Country(this.country);

  final formatter = new NumberFormat("#,###");
  var textSpacing = 0.7;

  @override
  Widget build(BuildContext context) {
    print(country);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          country['combinedKey'],
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
        child: Container(
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
                            formatter.format(country['confirmed']),
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
                            formatter.format(country['recovered']),
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
              
              // Active Patient
              Card(
                elevation: 0,
                color: Colors.yellow[700],
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
                            "Active Patient",
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
                            formatter.format(country['active']),
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

              // Active Patient end

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
                            formatter.format(country['deaths']),
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
}



