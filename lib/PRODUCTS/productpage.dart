import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:toast/toast.dart';

class Ppg extends StatefulWidget {
  // ignore: non_constant_identifier_names
  Ppg(
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
  _PpgState createState() {
    return _PpgState(
        db,
        name,
        cost,
        image1,
        image2,
        image3,
        image4,
        product_details,
        material_and_care,
        style_note,
        manufacturer_detail,
        country_of_origin,
        product_code,
        type);
  }
}

class _PpgState extends State<Ppg> {
  var data = ['S', 'M', 'L', 'XL'];
  int _value;
  final db;
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

  _PpgState(
      this.db,
      this.name,
      this.cost,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.product_details,
      this.material_and_care,
      this.style_note,
      this.manufacturer_detail,
      this.country_of_origin,
      this.product_code,
      this.type);

  @override
  Widget build(BuildContext context) {
    if (type == "Footwear") {
      data = ['3', '4', '5', '6', '7', '8', '9'];
    } else if (type == "Accessories") {
      data = ['One Size'];
      _value = 0;
    } else if (type == "New Born") {
      data = ['0-1M', '1-2M'];
    } else if (type == "Baby") {
      data = ['2-3M', '3-6M', '6-12M', '12-18M', '18-24M'];
    } else if (type == "Kids") {
      data = ['2-3Y', '3-4Y', '4-5Y', '5-6Y', '6-7Y', '7-8Y'];
    } else if (type == "Teens") {
      data = ['8-9Y', '9-10Y', '10-11Y', '11-12Y'];
    } else if (type == "Teen") {
      data = ['12-13Y', '13-14Y', '14-15Y', '15-16Y', '16-17Y'];
    } else if (type == "Age Group") {
      data = ['1-2Y', '3-5Y', '5-8Y', '8-10Y', '10-12Y', '12-15Y', '15-17Y'];
    } else if (type == "Baby Kids Footwear") {
      data = ['18.5E', '20.5E', '22E', '23E', '24E', '25E'];
    } else if (type == 'Small Kids Footwaer') {
      data = ['25E', '26E', '27E', '28E', '29E', '30E'];
    } else if (type == "Kids Footwear") {
      data = ['30E', '31E', '32E', '33E', '34E', '35E', '36E'];
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 20,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0)),
              SizedBox(
                height: 480.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5.0,
                  dotIncreasedColor: Color(0x42000000),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomRight,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: [
                    NetworkImage(image1),
                    NetworkImage(image2),
                    NetworkImage(image3),
                    NetworkImage(image4),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Text(
                  cost,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Text(
                  "Inclusive all tax",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF03A9F4)),
                ),
              ),
              Divider(thickness: 5),
              Text("Select size",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: List<Widget>.generate(
                  data.length,
                  (int index) {
                    return ChoiceChip(
                      label: Text(data[index]),
                      selected: _value == index,
                      avatarBorder: CircleBorder(),
                      shape:
                          StadiumBorder(side: BorderSide(color: Colors.black)),
                      backgroundColor: Colors.white,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? index : null;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton.icon(
                          icon: Icon(EvaIcons.shoppingCart, color: Colors.blue),
                          label: Text("Add to Cart"),
                          onPressed: () {
                            ///////////USER CART/////////////
                            Map<String, dynamic> cart = {
                              'Cart_Image1': image1,
                              'Cart_Image2': image2,
                              'Cart_Image3': image3,
                              'Cart_Image4': image4,
                              'Cart_Name': name,
                              'Cart_Cost': cost,
                              'Cart_Product_Details': product_details,
                              'Cart_Material_&_Care': material_and_care,
                              'Cart_Style_Note': style_note,
                              'Cart_Manufacturer_Detail': manufacturer_detail,
                              'Cart_Country_of_Origin': country_of_origin,
                              'Cart_Product_Code': product_code,
                              'Cart_Size': data[_value],
                              'Cart_Db': db,
                              'Cart_Order': "Placed"
                            };
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final User user = auth.currentUser;
                            final uid = user.uid;
                            CollectionReference usercart = FirebaseFirestore
                                .instance
                                .collection('USER CART');

                            usercart
                                .doc(uid)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                ///////////to check document exists or not
                                ///exits
                                usercart
                                    .doc(uid)
                                    .update({
                                      'Cart': FieldValue.arrayUnion([cart]),
                                    }) //////////USER CART///////
                                    .then((value) => Toast.show(
                                        "Item added to Cart", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.grey[300],
                                        textColor: Colors.black))
                                    .catchError((error) => Toast.show(
                                        "Error: $error", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.grey[300],
                                        textColor: Colors.black));
                              } else {
                                ////not exit
                                usercart
                                    .doc(uid)
                                    .set({
                                      'Cart': FieldValue.arrayUnion([cart]),
                                    }) //////////USER CART///////
                                    .then((value) => Toast.show(
                                        "Item added to Cart", context,
                                        duration: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.grey[300],
                                        gravity: Toast.BOTTOM))
                                    .catchError((error) => Toast.show(
                                        "Error: $error", context,
                                        duration: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.grey[300],
                                        gravity: Toast.BOTTOM));
                              }
                            });
                          }
                          /////USER CART////////
                          ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: OutlineButton.icon(
                          textColor: Colors.black,
                          icon: Icon(EvaIcons.heart, color: Colors.pink),
                          label: Text("Add to Wishlist"),
                          onPressed: () {
                            Map<String, dynamic> wishlist = {
                              'Wishlist_Image1': image1,
                              'Wishlist_Image2': image2,
                              'Wishlist_Image3': image3,
                              'Wishlist_Image4': image4,
                              'Wishlist_Name': name,
                              'Wishlist_Cost': cost,
                              'Wishlist_Product_Details': product_details,
                              'Wishlist_Material_&_Care': material_and_care,
                              'Wishlist_Style_Note': style_note,
                              'Wishlist_Manufacturer_Detail':
                                  manufacturer_detail,
                              'Wishlist_Country_of_Origin': country_of_origin,
                              'Wishlist_Product_Code': product_code,
                              'Wishlist_Size': data[_value],
                              'Wishlist_Db': db,
                            };
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final User user = auth.currentUser;
                            final uid = user.uid;
                            CollectionReference usercart = FirebaseFirestore
                                .instance
                                .collection('USER WISHLIST');

                            usercart
                                .doc(uid)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) {
                              if (documentSnapshot.exists) {
                                ///////////to check document exists or not
                                ///exits
                                usercart
                                    .doc(uid)
                                    .update({
                                      'Wishlist':
                                          FieldValue.arrayUnion([wishlist]),
                                    }) //////////USER CART///////
                                    .then((value) => Toast.show(
                                        "Item added to Wishlist", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.grey[300],
                                        textColor: Colors.black))
                                    .catchError((error) => Toast.show(
                                        "Error: $error", context,
                                        duration: Toast.LENGTH_SHORT,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.grey[300],
                                        textColor: Colors.black));
                              } else {
                                ////not exit
                                usercart
                                    .doc(uid)
                                    .set({
                                      'Wishlist':
                                          FieldValue.arrayUnion([wishlist]),
                                    }) //////////USER WISHLIST///////
                                    .then((value) => Toast.show(
                                        "Item added to Wishlist", context,
                                        duration: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.grey[300],
                                        gravity: Toast.BOTTOM))
                                    .catchError((error) => Toast.show(
                                        "Error: $error", context,
                                        duration: Toast.LENGTH_SHORT,
                                        backgroundColor: Colors.grey[300],
                                        gravity: Toast.BOTTOM));
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 5),
              Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      "Product Details",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product_details,
                    ),
                    Divider(),
                    Text(
                      "Material & Care",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      material_and_care,
                    ),
                    Divider(),
                    Text(
                      "Style Note",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      style_note,
                    ),
                    Divider(),
                    Text(
                      "Manufacturer Detail",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      manufacturer_detail,
                    ),
                    Divider(),
                    Text(
                      "Country of Origin",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      country_of_origin,
                    ),
                    Divider(),
                    Text(
                      "Product Code",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product_code,
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
