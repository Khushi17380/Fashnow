import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:flutter/material.dart';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:getwidget/getwidget.dart';

class Women extends StatefulWidget {
  @override
  _WomenState createState() {
    return _WomenState();
  }
}

class _WomenState extends State<Women> {
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
          'Women',
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
      stream: Firestore.instance.collection('Women').snapshots(),
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ExpansionTile(
                      title: Text(
                        'Indian & Fusion Wear',
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Kurtas & Suits'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Kurtas & Suits',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Kurtis,Tunics & Tops'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Kurtis,Tunics & Tops',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Ethnic Dresses'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Ethnic Dresses',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Leggings,Salwars & Churidars'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Leggings,Salwars & Churidars',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Skirts & Palazzos'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Skirts & Palazzos',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sarees'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Sarees',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Dresses Materials'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Dresses Materials',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('LehengaCholis'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women LehengaCholis',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Dupattas & Shawls'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Dupattas & Shawls',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Jakets & Waistcoats'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Jakets & Waistcoats',
                                  ),
                                ));
                          },
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Western Wear',
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text('Dresses'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Dresses',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Jumpsuits'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Jumpsuits',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Tops,T-Shirt & Shirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Tops,T-Shirt & Shirts',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Jeans & Jeggings'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Jeans & Jeggings',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Trousers & Capris'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Trousers & Capris',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Shorts & Skirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Shorts & Skirts',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Shrugs'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Shrugs',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Sweaters & Sweatshirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Sweaters & Sweatshirts',
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
                                    db: 'Women Jackets & Coats',
                                  ),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text('Blazers & Waistcoats'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Women Blazers & Waistcoats',
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Flats'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Flats',
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
                                db: 'Women Casual Shoes',
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
                                db: 'Women Formal Shoes',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Heels'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Heels',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Boots'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Boots',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Sports Shoes & Floaters'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sports Shoes & Floaters',
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
                    "Sports & Active Wear",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Clothing'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sports Clothing',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Footwear'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sports Footwear',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Sports Acessories'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sports Acessories',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Sports Equipment'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sports Equipment',
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
                    "Lingerie & Sleepwear",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Bra'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Bra',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Briefs'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Briefs',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Shapewear'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Shapewear',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Sleepwear & Loungewear'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Sleepwear & Loungewear',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Swimwear'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Swimwear',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Camisoles & Thermals'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Camisoles & Thermals',
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
                    "Beauty & Personal Care",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Makeup'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Makeup',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Skincare'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Skincare',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Premium Beauty'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Premium Beauty',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Lipsticks'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Lipsticks',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Fragrances'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Fragrances',
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
                    "Jewellery",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Fashion Jewellery'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Fashion Jewellery',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Earrings'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Earrings',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Lipsticks'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Lipsticks',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Fragrances'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Fragrances',
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
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text('Belts,Scarvres & more'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Belts,Scarvres & more',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Watches & Wearable'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Watches & Wearable',
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
                                db: 'Women Sunglasses & Frames',
                              ),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text('Handbags,Bags & Wallets'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pgrid(
                                db: 'Women Handbags,Bags & Wallets',
                              ),
                            ));
                      },
                    )
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
  final String image4;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['image1'] != null),
        assert(map['image2'] != null),
        assert(map['image3'] != null),
        assert(map['image4'] != null),
        image1 = map['image1'],
        image2 = map['image2'],
        image3 = map['image3'],
        image4 = map['image4'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$image1:$image2:$image3$image4>";
}
