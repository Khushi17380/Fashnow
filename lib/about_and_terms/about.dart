import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'ABOUT US',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 5,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          Padding(padding: EdgeInsets.all(30.0)),
          Center(
            child: Text("Fashnow/ About",
                style: TextStyle(fontSize: 28, color: Colors.grey[700])),
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Column(children: <Widget>[
            SizedBox(height: 20.0),
            ExpansionTile(
                title: Text(
                  "Introduction",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                        'Fashnow is one of the finest e-shop for all your fashion needs. It aims is to provide a hassle free and enjoyable shopping experience to our customer with the widest renge of products.',
                        style: TextStyle(color: Colors.grey)),
                  )
                ]),
            ExpansionTile(
                title: Text(
                  "Value proposition",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                        "Fashnow's value proposition revolves around giving customer th power and ease of purchasing fashion products virtually anywhere and everywhere. Because of this, shopping for stuff is more fun than its ever before.",
                        style: TextStyle(color: Colors.grey)),
                  )
                ]),
            ExpansionTile(
                title: Text(
                  "Brands",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                children: <Widget>[
                  ListTile(
                    title: Text(
                        "Fashnow understands its shoppers needs and caters to them with choice of apparel, accessoriess, cosmetics and footwear from over latest and branded items.",
                        style: TextStyle(color: Colors.grey)),
                  )
                ])
          ])
        ])));
  }
}
