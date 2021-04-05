import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:flutter/material.dart';

//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'package:getwidget/getwidget.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

class Kids extends StatefulWidget {
  @override
  _KidsState createState() {
    return _KidsState();
  }
}

class _KidsState extends State<Kids> {
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
          'Kids',
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
      stream: Firestore.instance.collection('Kids').snapshots(),
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
                "Shop by age",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: <Widget>[
                  OutlineGradientButton(
                    child: Text('NEW BORN\n(0-3months)',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    gradient: SweepGradient(
                      colors: List.generate(
                          360,
                          (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5)
                              .toColor()),
                    ),
                    strokeWidth: 2,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    radius: Radius.circular(8),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pgrid(
                              db: 'Kids New Born',
                            ),
                          ));
                    },
                  ),
                  OutlineGradientButton(
                    child: Text('BABY\n(2months-2years)',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    gradient: SweepGradient(
                      colors: List.generate(
                          360,
                          (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5)
                              .toColor()),
                    ),
                    strokeWidth: 2,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    radius: Radius.circular(8),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pgrid(
                              db: 'Kids Baby',
                            ),
                          ));
                    },
                  ),
                  OutlineGradientButton(
                    child: Text('KIDS\n(2-8years)',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    gradient: SweepGradient(
                      colors: List.generate(
                          360,
                          (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5)
                              .toColor()),
                    ),
                    strokeWidth: 2,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    radius: Radius.circular(8),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pgrid(
                              db: 'Kids Kids',
                            ),
                          ));
                    },
                  ),
                  OutlineGradientButton(
                    child: Text('TEENS\n(8-12years)',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    gradient: SweepGradient(
                      colors: List.generate(
                          360,
                          (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5)
                              .toColor()),
                    ),
                    strokeWidth: 2,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    radius: Radius.circular(8),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pgrid(
                              db: 'Kids Teens',
                            ),
                          ));
                    },
                  ),
                  OutlineGradientButton(
                    child: Text('TEEN\n(12years +)',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    gradient: SweepGradient(
                      colors: List.generate(
                          360,
                          (h) => HSLColor.fromAHSL(1, h.toDouble(), 1, 0.5)
                              .toColor()),
                    ),
                    strokeWidth: 2,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    radius: Radius.circular(8),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pgrid(
                              db: 'Kids Teen',
                            ),
                          ));
                    },
                  ),
                ]),
            //gradient finished
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Image.network(record.image5)],
                ),
              ),
            ),

//Evalution-Start
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
                      "Girls Clothing",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      ListTile(
                        title: Text('Dresses,Dungararees & Jumpsuits'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Girls Dresses,Dungararees & Jumpsuits',
                                ),
                              ));
                        },
                      ),
                      ListTile(
                          title: Text('Tops & T-shirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Tops & T-shirts',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Ethnic Wear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Ethnic Wear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Party Wear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Party Wear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Clothing Sets'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Clothing Sets',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Skirts & Shorts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Skirts & Shorts',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Jeans,Trousers & Capris'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Jeans,Trousers & Capris',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Leggings & Trackpants'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Leggings & Trackpants',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Nightwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Nightwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Innerwear & thermals'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Innerwear & thermals',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Winterwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Winterwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Swimwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Swimwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Sports & Activewear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Sports & Activewear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Socks'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Girls Socks',
                                  ),
                                ));
                          })
                    ]),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                ExpansionTile(
                    title: Text(
                      "Boys Clothing",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      ListTile(
                          title: Text('T-shirts & Shirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys T-shirts & Shirts',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Jeans & Trousers'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Jeans & Trousers',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Shorts & Jamaicann / Bermudas'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Shorts & Jamaicann / Bermudas',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Trackpants'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Trackpants',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Clothing Sets'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Clothing Sets',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Ethnicwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Ethnicwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Paty Wear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Paty Wear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Nightwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Nightwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Innerwear & thermals'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Innerwear & thermals',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Winterwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Winterwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Swimwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Swimwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Sports & Activewear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Sports & Activewear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Socks'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Boys Socks',
                                  ),
                                ));
                          })
                    ]),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                ExpansionTile(
                    title: Text(
                      "Baby",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    children: <Widget>[
                      ListTile(
                          title: Text('Rompers, Onesies & Sleepsuits'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Rompers, Onesies & Sleepsuits',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Clothing Sets'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Clothing Sets',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Value Packs'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Value Packs',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Dresses'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Dresses',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Tops, T-shirts & Shirts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Tops, T-shirts & Shirts',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Leggings & Trackpants'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Leggings & Trackpants',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Skirts & Shorts'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Skirts & Shorts',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Nightwear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Nightwear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Innerwear & thermals'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Innerwear & thermals',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Jeans & Trousers'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Jeans & Trousers',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Etnic & Partywear'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Etnic & Partywear',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Bibs, mittens & thermals'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Bibs, mittens & thermals',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Booties'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Booties',
                                  ),
                                ));
                          }),
                      ListTile(
                          title: Text('Baby Essential'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pgrid(
                                    db: 'Kids Baby Essential',
                                  ),
                                ));
                          })
                    ]),
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
                    ExpansionTile(
                      title: Text(
                        'Girls Footwear',
                      ),
                      children: <Widget>[
                        ListTile(
                            title: Text('Casual Shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Casual Shoes',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Flats'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Flats',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sandals & heels'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Sandals & heels',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Flip flops & clogs'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Flip flops & clogs',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sports Shoes & Sports Sandals'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Sports Shoes & Sports Sandals',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Ethnic Footwear'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Ethnic Footwear',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('School Shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls School Shoes',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Booties'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Booties',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sock shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Girls Sock shoes',
                                    ),
                                  ));
                            })
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        'Boys Footwear',
                      ),
                      children: <Widget>[
                        ListTile(
                            title: Text('Casual Shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Casual Shoes',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sports Shoes & Sports Sandals'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Sports Shoes & Sports Sandals',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Flip flops & clogs'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Flip flops & clogs',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sandals'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Sandals',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('School Shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys School Shoes',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Occassion Footwear'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Occassion Footwear',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Booties'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Booties',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Sock shoes'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Sock shoes',
                                    ),
                                  ));
                            }),
                        ListTile(
                            title: Text('Socks'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Pgrid(
                                      db: 'Kids Boys Socks',
                                    ),
                                  ));
                            })
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
                    "Acessories",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                        title: Text('Socks'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Socks',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Caps & hats'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Caps & hats',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Sunglasses & Frames'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Sunglasses & Frames',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Ties,Belts & Suspenders'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Ties,Belts & Suspenders',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Hair Accessories'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Hair Accessories',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Jewellery'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Jewellery',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Watches'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Watches',
                                ),
                              ));
                        })
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                ExpansionTile(
                  title: Text(
                    "Bags & Backpacks",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                        title: Text('Sports Acessories & Equipment'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Sports Acessories & Equipment',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Bags & Backpacks'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Bags & Backpacks',
                                ),
                              ));
                        }),
                    ListTile(
                        title: Text('Trolley Bags'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pgrid(
                                  db: 'Kids Trolley Bags',
                                ),
                              ));
                        })
                  ],
                ),
              ],
            )
          ])),
    );
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
