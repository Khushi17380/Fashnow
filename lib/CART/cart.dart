import 'package:fashnow_/Address&Payments/address_details.dart';
import 'package:fashnow_/Address&Payments/add_address.dart';
import 'package:fashnow_/my_orders/order&cartview.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

var format = NumberFormat.currency(locale: 'HI');
CollectionReference usercart =
    FirebaseFirestore.instance.collection('USER CART');

double tcost;
String ftcost;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<dynamic, dynamic>> values = [];
  Future<void> readCartData() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER CART').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        values = List.from(doc.data()['Cart']);
      });
    });
  }

  Future<void> findtcost() async {
    int i = 0;
    tcost = 0;
    ftcost = "0";
    var length = values.length;
    while (i != length) {
      setState(() {
        String p =
            values[i]['Cart_Cost'].replaceAll(new RegExp(r'[^\w\s]+'), '');
        var myDouble = double.parse(p);
        assert(myDouble is double);
        tcost = tcost + myDouble;
        ftcost = format.format(tcost);
        i++;
      });
    }
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
    readCartData();
    findtcost();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Cart',
            style: TextStyle(
              color: Colors.purple[200],
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 5,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black)),
      body: ListView.builder(
        itemCount: values.length,
        itemBuilder: (context, index) {
          return Container(
              child: SingleChildScrollView(
                  child: Center(
                      child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                GFCard(
                  color: Colors.grey[100],
                  title: GFListTile(
                    avatar: GFAvatar(
                        backgroundImage:
                            NetworkImage(values[index]['Cart_Image1']),
                        shape: GFAvatarShape.standard),
                    title: Text(values[index]['Cart_Name'],
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w600)),
                    subTitle: Text(values[index]['Cart_Cost']),
                  ),
                  content: Text('Size: ${values[index]['Cart_Size']}'),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ignore: missing_required_param
                                builder: (context) => OPpg(
                                  db: '${values[index]['Cart_Db']}',
                                  product_code:
                                      '${values[index]['Cart_Product_Code']}',
                                ),
                              ));
                        },
                        text: 'View',
                        type: GFButtonType.transparent,
                        size: GFSize.LARGE,
                      ),
                      GFButton(
                        ////To remove item from cart/////////////////
                        onPressed: () {
                          usercart
                              .doc(uid)
                              .update({
                                'Cart': FieldValue.arrayRemove([values[index]])
                              })
                              .then((value) => Toast.show(
                                  "Item Deleted", context,
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
                          readCartData();
                          findtcost();
                        },
                        text: 'Remove',
                        type: GFButtonType.transparent,
                        size: GFSize.LARGE,
                      ),
                    ],
                  ),
                ),
              ]))));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 100.0,
        child: Container(
            height: 100,
            child: Row(children: <Widget>[
              Text('Total Cost: $ftcost',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600)),
              Container(
                child: Column(children: <Widget>[
                  Text('Items:${values.length}',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black54))
                ]),
              ),
              // Spacer(),
              GFButton(
                onPressed: () {
                  print(values);
                  if (values.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('USER ADDRESS')
                        .doc(uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddressDetails(),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Address(),
                            ));
                      }
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Cart is Empty'),
                            actions: <Widget>[
                              SizedBox(
                                  height: 50,
                                  width: 800,
                                  child: GFButton(
                                    elevation: 100,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    text: "OK",
                                    textStyle: TextStyle(fontSize: 18.0),
                                    shape: GFButtonShape.square,
                                    color: Colors.red,
                                    buttonBoxShadow: true,
                                    size: GFSize.LARGE,
                                  )),
                            ],
                          );
                        });
                  }
                },
                text: "PLACE ORDER",
                textStyle: TextStyle(fontSize: 18.0),
                shape: GFButtonShape.pills,
                color: Colors.red,
                buttonBoxShadow: true,
                size: GFSize.LARGE,
              ),
            ])),
        color: Colors.white,
      ),
    );
  }
}
