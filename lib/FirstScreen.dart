import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/CART/cart.dart';
import 'package:fashnow_/CART/wishlist.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:fashnow_/about_and_terms/about.dart';
import 'package:fashnow_/about_and_terms/terms.dart';
import 'package:fashnow_/categories/beauty/beauty.dart';
import 'package:fashnow_/my_orders/my_orders.dart';
import 'package:fashnow_/search/search.dart';
import 'package:flutter/material.dart';
import 'package:fashnow_/login_page.dart';
import 'package:fashnow_/sign_in.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/services.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:fashnow_/categories/women/women.dart';
import 'package:fashnow_/categories/men/men.dart';
import 'package:fashnow_/categories/kids/kids.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List bannerAdSlider = [];

  GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  iState() {
    var query =
        // ignore: deprecated_member_use
        Firestore.instance.collection('HOME SLIDER').document('HOME SLIDER');
    query.snapshots().forEach((doc) {
      setState(() {
        bannerAdSlider = doc.data()['HOME SLIDER'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    iState();
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        //centerTitle: true,
        title: Text(
          "Fashnow",
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
          onPressed: () {
            drawerKey.currentState.openDrawer();
          },
          icon: Icon(EvaIcons.menu2Outline),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // ignore: missing_required_param
              showSearch(context: context, delegate: DataSearch());
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Wishlist()),
              );
            },
            icon: Icon(EvaIcons.heartOutline),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
            icon: Icon(EvaIcons.shoppingCart),
          ),
        ],
      ),
      drawerEdgeDragWidth: 0,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFE1BEE7)),
              accountName: Text(name),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(height: 10),
            ListTile(
                title: Text("My Order/s"),
                leading: Icon(EvaIcons.personOutline),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyOrder()),
                  );
                }),
            SizedBox(height: 10),
            ListTile(
                title: Text("Cart"),
                leading: Icon(EvaIcons.shoppingCart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                }),
            SizedBox(height: 10),
            ListTile(
                title: Text("Wish List"),
                leading: Icon(EvaIcons.heartOutline),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Wishlist()),
                  );
                }),
            Divider(),
            SizedBox(height: 10),
            ListTile(
                title: Text("About Us"),
                leading: Icon(FrinoIcons.f_group),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                }),
            SizedBox(height: 10),
            ListTile(
                title: Text("Terms & Condition"),
                leading: Icon(FrinoIcons.f_stempel),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndCondition()),
                  );
                }),
            Divider(),
            SizedBox(height: 10),
            ListTile(
              title: Text("Sign Out"),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
              SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Men()),
                        );
                      },
                      color: Color(0xFFffe291),
                      textColor: Colors.white,
                      child: Icon(
                        FrinoIcons.f_male,
                        size: 50,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Women()),
                        );
                      },
                      color: Color(0xFF91bfff),
                      textColor: Colors.white,
                      child: Icon(
                        FrinoIcons.f_female,
                        size: 50,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Kids()),
                        );
                      },
                      color: Color(0xFFff91c1),
                      textColor: Colors.white,
                      child: Icon(
                        FrinoIcons.f_child,
                        size: 50,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Beauty()),
                        );
                      },
                      color: Color(0xFF5340de),
                      textColor: Colors.white,
                      child: Icon(
                        FrinoIcons.f_colour_palette,
                        size: 50,
                      ),
                      padding: EdgeInsets.all(10),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),
              // banner ad slider

              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                ),
                items: bannerAdSlider.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: NetworkImage(i),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),

              // banner ad slider

              SizedBox(
                height: 20,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "INDIA'S BIGGEST FASHION",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 25,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "FOR HIM",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
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
                                  db: 'Men T-shirts',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's T-Shirt.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("T-Shirts"),
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
                                  db: 'Men Sports Shoes',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Sport Shoes.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Sport Shoes"),
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
                                  db: 'Men Casual Shoes',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Casual Shoes.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Casual Shoes"),
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
                                  db: 'Men Track Pants & Joggers',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Track Pants.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Track Pants"),
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
                                  db: 'Men Flip Flops',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Flip Flop.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Flip Flops"),
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
                                  db: 'Men Jeans',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Jeans.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Jeans"),
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
                                  db: 'Men Jackets & Coats',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Jackets.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Jacket&Coats"),
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
                                  db: 'Men Casual Trousers',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: ExactAssetImage(
                              "assets/Men's Casual Trousers.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Casual Trouser"),
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
                                  db: 'Men Kurtas & Kurta Sets',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Kurta.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Kurta"),
                    ],
                  ),
                ])
              ])),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "FOR HER",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
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
                                  db: 'Women Dresses',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Dress.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Dresses"),
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
                                  db: 'Women Sarees',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Saree.jpeg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Sarees"),
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
                                  db: 'Women Heels',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Heel.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Heels"),
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
                                  db: 'Women Handbags,Bags & Wallets',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Handbag.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Handbags"),
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
                                  db: 'Women Boots',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Boot.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Boots"),
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
                                  db: 'Women Jeans & Jeggings',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Jeans.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Jeans"),
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
                                  db: 'Women Jackets & Waistcoats',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Jacket.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Jackets"),
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
                                  db: 'Women Tops,T-Shirt & Shirts',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Top.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Top"),
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
                                  db: 'Women Kurta & Suits',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Women's Kurta.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Kurta&Suits"),
                    ],
                  )
                ])
              ])),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "BEAUTY & GROOMING",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
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
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Men's Grooming.jpg"),
                        ),
                      ),
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
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: ExactAssetImage(
                              "assets/Women's Premium Beauty.jpg"),
                        ),
                      ),
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
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Fragrances & Deos.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Fragrances"),
                      Text("& Deos")
                    ],
                  )
                ])
              ])),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "ACCESSORIES, BAGS & MORE",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
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
                                  db: 'Watches',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Watches.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Watches"),
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
                                  db: 'Belts & Wallets',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Belts & Wallets.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Belts &"),
                      Text("Wallets"),
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
                                  db: 'Trollybag & Bagpacks',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: ExactAssetImage(
                              "assets/Trollybags & Bagpacks.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Trollybags"),
                      Text("& Bagpacks")
                    ],
                  )
                ])
              ])),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "FOR KIDS",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                      fontFamily: "poppins"),
                ),
              )),
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
                                  db: 'Kids Footwear',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Kids Footwear.jpeg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Footwear"),
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
                                  db: 'Kids Jewellery',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Kids Jewellery.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Jewellery"),
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
                                  db: 'Kids Indianwear',
                                ),
                              ));
                        },
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              ExactAssetImage("assets/Kids Indianwear.jpg"),
                        ),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Text("Indian Wear"),
                    ],
                  )
                ])
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
