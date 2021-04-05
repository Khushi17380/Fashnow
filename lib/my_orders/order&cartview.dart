import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:toast/toast.dart';

class OPpg extends StatefulWidget {
  OPpg(
      {@required this.db,
      // ignore: non_constant_identifier_names
      this.product_code});
  final db;
  // ignore: non_constant_identifier_names
  final product_code;

  @override
  _OPpgState createState() {
    return _OPpgState(db, product_code);
  }
}

class _OPpgState extends State<OPpg> {
  final db;
  // ignore: non_constant_identifier_names
  final product_code;
  _OPpgState(this.db, this.product_code);
  // ignore: non_constant_identifier_names
  String image1,
      image2,
      image3,
      image4,
      name,
      cost,
      // ignore: non_constant_identifier_names
      product_details,
      // ignore: non_constant_identifier_names
      material_and_care,
      // ignore: non_constant_identifier_names
      style_note,
      // ignore: non_constant_identifier_names
      manufacturer_detail,
      // ignore: non_constant_identifier_names
      country_of_origin,
      type;
  var data = ['S', 'M', 'L', 'XL'];
  int _value;
  Future<void> readOrder() async {
    // ignore: deprecated_member_use
    var query =
        // ignore: deprecated_member_use
        Firestore.instance
            .collection(db)
            .where('Product Code', isEqualTo: '$product_code');
    // ignore: deprecated_member_use
    query
      // ignore: deprecated_member_use
      ..getDocuments().then((snapshot) {
        // ignore: deprecated_member_use
        snapshot.documents.forEach((doc) {
          setState(() {
            // ignore: deprecated_member_use

            image1 = doc.data()['image1'];
            image2 = doc.data()['image2'];
            image3 = doc.data()['image3'];
            image4 = doc.data()['image4'];
            name = doc.data()['Name'];
            cost = doc.data()['Cost'];
            product_details = doc.data()['Product Details'];

            material_and_care = doc.data()['Material & Care'];

            style_note = doc.data()['Style Note'];

            manufacturer_detail = doc.data()['Manufacturer Detail'];

            country_of_origin = doc.data()['Country of Origin'];
            type = doc.data()['Type'];
          });
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    readOrder();
    if (type == "Footwear") {
      data = ['3', '4', '5', '6', '7', '8'];
    } else if (type == "Acessories") {
      data = ['One Size'];
      _value = 0;
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
                              'Cart_Db': db
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
                        onPressed: () {},
                      ),
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
