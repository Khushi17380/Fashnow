import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fashnow_/PRODUCTS/productpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';

class Pgrid extends StatefulWidget {
  // ignore: non_constant_identifier_names
  Pgrid(
      {@required this.db,
      this.name,
      this.cost,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      // ignore: non_constant_identifier_names
      this.product_details,
      // ignore: non_constant_identifier_names
      this.material_and_care,
      // ignore: non_constant_identifier_names
      this.style_note,
      // ignore: non_constant_identifier_names
      this.manufacturer_detail,
      // ignore: non_constant_identifier_names
      this.country_of_origin,
      // ignore: non_constant_identifier_names
      this.product_code,
      this.type});
  final db;
  //final title;
  final name;
  final cost;
  final image1;
  final image2;
  final image3;
  final image4;
  // ignore: non_constant_identifier_names
  final product_details;
  // ignore: non_constant_identifier_names
  final material_and_care;
  // ignore: non_constant_identifier_names
  final style_note;
  // ignore: non_constant_identifier_names
  final manufacturer_detail;
  // ignore: non_constant_identifier_names
  final country_of_origin;
  // ignore: non_constant_identifier_names
  final product_code;
  final type;

  @override
  _PgridState createState() {
    return _PgridState(db);
  }
}

class _PgridState extends State<Pgrid> {
  String db;
  var query;
  _PgridState(this.db);

  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    query = Firestore.instance.collection(db).snapshots();
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    Future<void> dialog() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Range'),
              actions: <Widget>[
                Wrap(spacing: 10, children: <Widget>[
                  Container(
                      child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      setState(() {
                        // ignore: deprecated_member_use
                        query = Firestore.instance
                            .collection(db)
                            .where('Price', isLessThanOrEqualTo: 500)
                            .snapshots();
                        Navigator.pop(context);
                      });
                    },
                    text: "Less than ₹500",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.pills,
                    color: Colors.grey,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                  Container(
                      child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      setState(() {
                        // ignore: deprecated_member_use
                        query = Firestore.instance
                            .collection(db)
                            .where('Price', isGreaterThanOrEqualTo: 500)
                            .where('Price', isLessThanOrEqualTo: 700)
                            .snapshots();
                        Navigator.pop(context);
                      });
                    },
                    text: "₹500-₹700",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.pills,
                    color: Colors.grey,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                  Container(
                      child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      setState(() {
                        // ignore: deprecated_member_use
                        query = Firestore.instance
                            .collection(db)
                            .where('Price', isGreaterThanOrEqualTo: 700)
                            .where('Price', isLessThanOrEqualTo: 800)
                            .snapshots();
                        Navigator.pop(context);
                      });
                    },
                    text: "₹700-₹800",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.pills,
                    color: Colors.grey,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                  Container(
                      child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      setState(() {
                        // ignore: deprecated_member_use
                        query = Firestore.instance
                            .collection(db)
                            .where('Price', isGreaterThanOrEqualTo: 800)
                            .where('Price', isLessThanOrEqualTo: 1000)
                            .snapshots();
                        Navigator.pop(context);
                      });
                    },
                    text: "₹800-₹1000",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.pills,
                    color: Colors.grey,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                  Container(
                      child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      setState(() {
                        // ignore: deprecated_member_use
                        query = Firestore.instance
                            .collection(db)
                            .where('Price', isGreaterThanOrEqualTo: 1000)
                            .snapshots();
                        Navigator.pop(context);
                      });
                    },
                    text: "Above ₹1000",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.pills,
                    color: Colors.grey,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                ])
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          db,
          style: TextStyle(
            color: Colors.purple[200],
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 20,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: StreamBuilder<QuerySnapshot>(
              // ignore: deprecated_member_use
              stream: query,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new Container(
                      child: SingleChildScrollView(
                        //key: ValueKey(document.data()['image1']),
                        child: Center(
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              // SizedBox(
                              //child:
                              Container(
                                //margin: const EdgeInsets.all(5.0),
                                color: Colors.amber,
                                child: Center(
                                    child: Text(
                                  'Genuine Products & Easy Returns',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )),
                                width: MediaQuery.of(context).size.width,
                                height: 56,
                              ),
                              OutlineButton.icon(
                                  textColor: Colors.black,
                                  icon: Icon(EvaIcons.funnel),
                                  label: Text("Filter by Cost"),
                                  onPressed: () {
                                    dialog();
                                  }),
                              //),
                              GridView.count(
                                physics: ClampingScrollPhysics(),
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                padding: EdgeInsets.all(16.0),
                                childAspectRatio: 18.0 / 39.0,
                                // ignore: deprecated_member_use
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey[100],
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Hero(
                                              tag: document.data()['image1'],
                                              child: AspectRatio(
                                                aspectRatio: 18.0 / 25.0,
                                                child: Image(
                                                  image: NetworkImage(document
                                                      .data()['image1']),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16.0, 12.0, 16.0, 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "${document.data()['Name']}",
                                                  ),
                                                  SizedBox(height: 8.0),
                                                  Text(
                                                      "${document.data()['Cost']}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  // ignore: missing_required_param
                                                  builder: (context) => Ppg(
                                                      db: db,
                                                      name: document
                                                          .data()['Name'],
                                                      cost: document
                                                          .data()['Cost'],
                                                      image1: document
                                                          .data()['image1'],
                                                      image2: document
                                                          .data()['image2'],
                                                      image3: document
                                                          .data()['image3'],
                                                      image4: document
                                                          .data()['image4'],
                                                      product_details:
                                                          document.data()[
                                                              'Product Details'],
                                                      material_and_care:
                                                          document.data()[
                                                              'Material & Care'],
                                                      style_note: document
                                                          .data()['Style Note'],
                                                      manufacturer_detail:
                                                          document.data()[
                                                              'Manufacturer Detail'],
                                                      country_of_origin:
                                                          document.data()[
                                                              'Country of Origin'],
                                                      product_code: document.data()['Product Code'],
                                                      type: document.data()['Type']),
                                                ));
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
              },
            )),
      ),
    );
  }
}
