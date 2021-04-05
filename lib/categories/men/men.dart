import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:flutter/material.dart';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:getwidget/getwidget.dart';

class Men extends StatefulWidget {
  @override
  _MenState createState() {
    return _MenState();
  }
}

class _MenState extends State<Men> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Men',
          style: TextStyle(
            color: Colors.purple[200],
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 5,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // ignore: deprecated_member_use
      stream: Firestore.instance.collection('Men').snapshots(),
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0)),
                SizedBox(
                  height: 250.0,
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Select Item",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ExpansionTile(
                      title: Text(
                        "Clothing",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      children: <Widget>[
                        ExpansionTile(
                          title: Text(
                            'Top Wear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('T-Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men T-shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Casual Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Casual Shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Formal Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Formal Shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Sweater & Sweat Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Sweater & Sweat Shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Jackets & Coats'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Jackets & Coats',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Clothing Fabric'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Clothing Fabric',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            'Bottom Wear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Jeans'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Jeans',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Casual Trousers'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Casual Trousers',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Formal Trousers'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Formal Trousers',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Shorts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Shorts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Track Pants/Joggers'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Track Pants & Joggers',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            'Sports & Active Wear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Active T-Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Active T-Shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Track pants & Shorts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Track Pants & Shorts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Jackets & Sweatshirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Jackets & Sweatshirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Sports Shoes'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Sports Shoes',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            'Indian & Festive Wear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Kurtas & Kurta Sets'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Kurtas & Kurta Sets',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Sherwanis'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Sherwanis',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Nehru Jackets'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Nehru Jackets',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Dhoti'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Dhoti',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            'Innerwear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Explore All Innerwear'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Explore All Innerwear',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Briefs & Trunks'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Briefs & Trunks',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Boxers'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Boxers',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Vetsts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Vetsts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Socks'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Socks',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Handkerchiefs'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Handkerchiefs',
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            'Sleepwear',
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Lounge Pants'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Lounge Pants',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Lounge Shorts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Lounge Shorts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Lounge T-Shirts'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Lounge T-Shirts',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Night Suits'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Night Suits',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Track pants'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Track pants',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ExpansionTile(
                      title: Text(
                        "Footwear",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Sneakers'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Sneakers',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Casual Shoes'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Casual Shoes',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Formal Shoes'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Formal Shoes',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sports Shoes'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Sports Shoes',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sandals & Floaters'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Sandals & Floaters',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Flip Flops'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Flip Flops',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Socks'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Socks',
                                  ),
                                ));
                          },
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    ExpansionTile(
                      title: Text(
                        "Acessories",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Watches & Wearables'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Watches & Wearables',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sunglasses & Frames'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Sunglasses & Frames',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Wallets'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Wallets',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sports Shoes'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Sports Shoes',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Belts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Belts',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Caps & Hats'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Caps & Hats',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Travel Acessories'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Travel Acessories',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Mufflers,Scarves & Gloves'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Men Mufflers,Scarves & Gloves',
                                  ),
                                ));
                          },
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        ExpansionTile(
                          title: Text(
                            "Personal Care & Grooming",
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          children: <Widget>[
                            ListTile(
                              title: Text('Fragrances'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Fragrances',
                                      ),
                                    ));
                              },
                            ),
                            ListTile(
                              title: Text('Grooming'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Pgrid(
                                        db: 'Men Grooming',
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ])),
    );
  }
}

class Record {
  final String image1;
  final String image2;
  final String image3;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['image1'] != null),
        assert(map['image2'] != null),
        assert(map['image3'] != null),
        image1 = map['image1'],
        image2 = map['image2'],
        image3 = map['image3'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$image1:$image2:$image3>";
}
