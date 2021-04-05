import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fashnow_/FirstScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:fashnow_/login_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:fashnow_/sign_in.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      title: "Fashnow",
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    debugPrint("Started");
    Timer(Duration(seconds: 3), finished);
  }

  void finished() async {
    debugPrint("Finished");
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => NoInternet()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      title: new Text(
        'Dress up Dress shop',
        textScaleFactor: 2,
      ),
      image: new Image.asset('assets/logo2.png'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.purple[200],
    );
  }
}

class NoInternet extends StatefulWidget {
  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //centerTitle: true,
          title: Text(
            'FASHNOW',
            style: TextStyle(
              color: Colors.purple[200],
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 5,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(EvaIcons.menu2Outline),
          ),
        ),
        body: Center(
            child: Column(children: <Widget>[
          Padding(padding: EdgeInsets.all(90)),
          Text("No Internet Connection...",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25)),
          Padding(padding: EdgeInsets.all(20)),
          FlatButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Splash()));
              },
              child: Text('RETRY',
                  style: TextStyle(color: Colors.blue, fontSize: 20)))
        ])));
  }
}
