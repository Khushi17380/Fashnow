import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:flutter/material.dart';

class Beauty extends StatefulWidget {
  @override
  _BeautyState createState() => _BeautyState();
}

class _BeautyState extends State<Beauty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beauty',
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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // ignore: deprecated_member_use
      stream: Firestore.instance.collection('Beauty').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        // ignore: deprecated_member_use
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Container(
        child: SingleChildScrollView(
            key: ValueKey(record.image1),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0)),
              SizedBox(
                height: 350.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5.0,
                  dotIncreasedColor: Color(0xFFE1BEE7),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomRight,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: [
                    NetworkImage(record.image1),
                    NetworkImage(record.image2),
                    NetworkImage(record.image3),
                    NetworkImage(record.image4),
                    NetworkImage(record.image5)
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Text(
                  "Beauty Must Have",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue[900],
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                  title: Row(children: <Widget>[
                Wrap(spacing: 10, children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Grooming',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Men's Grooming.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Grooming"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Premium Beauty',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Women's Premium Beauty.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Premium"),
                      Text("Beauty"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Fragrances & Deos',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Fragrances & Deos.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Fragrances"),
                      Text("& Deos")
                    ],
                  )
                ])
              ])),
              ListTile(
                  title: Row(children: <Widget>[
                Wrap(spacing: 10, children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Lipsticks',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Women's Lipstick.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Lipsticks"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Makeup',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Women's Makeup.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Makeup")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Essential',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Baby Essential.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Baby"),
                      Text("Essential")
                    ],
                  )
                ])
              ])),
              ListTile(
                  title: Row(children: <Widget>[
                Wrap(spacing: 10, children: [
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Skincare',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Skincare.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Skincare"),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Beauty & Grooming Application',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 106,
                            height: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  28.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Hairdryer.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Beauty &"),
                      Text("Grooming"),
                      Text("Application")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(height: 32.0),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Wellness',
                                  ),
                                ));
                          },
                          child: Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), //add border radius here
                              child: Image.asset(
                                  "assets/Wellness.jpg"), //add image location here
                            ),
                          )),
                      Container(
                        height: 20.0,
                      ),
                      Text("Wellness &"),
                      Text("Hygiene"),
                      Text("Essential")
                    ],
                  )
                ])
              ])),
            ])));
  }
}

class Record {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String image5;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['image1'] != null),
        assert(map['image2'] != null),
        assert(map['image3'] != null),
        assert(map['image4'] != null),
        assert(map['image5'] != null),
        image1 = map['image1'],
        image2 = map['image2'],
        image3 = map['image3'],
        image4 = map['image4'],
        image5 = map['image5'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$image1:$image2:$image3:$image4:$image5>";
}
