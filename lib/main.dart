import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String prefData;
  TextEditingController currencyController = TextEditingController();
  SharedPreferences myPrefs;

  //read peferences
  Future<String> loadPrefs() async {
    myPrefs = await SharedPreferences.getInstance();
    myPrefs.getString("currency");
  }

  @override
  void initState() {
    //call read preferences
    loadPrefs().then((data) {
      //Map decodedData = jsonDecode(data);
      print(data);
      setState(() {
        prefData = data; //decodedData['api_key'];
      });
    });

    super.initState();
  }

  // 1 - currect currency - USD
  // 2 - for field to accept new value
  // 3  -button to save value to shared prefs

  //restart app to verify changes
  void updateCurrency() {
    setState(() {
      prefData = currencyController.text; //decodedData['api_key'];
    });
  }

  void updatePrefs() async {
    String val = currencyController.text;
    print("Saving value : $val");
    await myPrefs.setString("currency", val);
  }

  @override
  Widget build(BuildContext context) {
    // print(configData);
    return MaterialApp(
      home: Scaffold(
        //app bar
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Current currency",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("$prefData"),
              SizedBox(
                width: 20.0,
              ),
              Text("Add Currency"),
              TextField(
                // decoration: InputDecoration(
                //   border: InputBorder.none,
                // ),
                controller: currencyController,
                // keyboardType: TextInputType.number,
                onChanged: (value) {
                  updateCurrency();
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                child: Text("Update Currency"),
                onPressed: updatePrefs,
              )
            ],
          ),
        ),
      ),
    );
  }
}
