import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/Address&Payments/add_address.dart';
import 'package:fashnow_/Address&Payments/edit_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'payment_method.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class AddressDetails extends StatefulWidget {
  @override
  _AddressDetailsState createState() => _AddressDetailsState();
}

class _AddressDetailsState extends State<AddressDetails> {
  // ignore: non_constant_identifier_names
  String name, address, town, city, pincode, state, mob, address_type;

  Future<void> readAddress() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER ADDRESS').document(uid);
    query.snapshots().forEach((doc) {
      if (this.mounted) {
        setState(() {
          name = doc.data()['Name'];
          address = doc.data()['Address'];
          town = doc.data()['Locality'];
          city = doc.data()['City'];
          pincode = doc.data()['Pincode'];
          state = doc.data()['State'];
          mob = doc.data()['Mobile Number'];
          address_type = doc.data()['Address Type'];
        });
      }
    });
  }

  String formattedDate;
  void date() async {
    if (this.mounted) {
      setState(() {
        var now = new DateTime.now().add(Duration(days: 7, hours: 10));
        var formatter = new DateFormat('dd-MM-yyyy');
        formattedDate = formatter.format(now);
      });
    }
  }

  List<Map<dynamic, dynamic>> values = [];
  double tcost;
  String ftcost;
  var format = NumberFormat.currency(locale: 'HI');

  Future<void> readCartData() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER CART').document(uid);
    query.snapshots().forEach((doc) {
      if (this.mounted) {
        setState(() {
          values = List.from(doc.data()['Cart']);
        });
      }
    });
  }

  Future<void> findtcost() async {
    int i = 0;
    tcost = 0;
    ftcost = "0";
    var length = values.length;
    while (i != length) {
      if (this.mounted) {
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
    readAddress();
    date();
    readCartData();
    findtcost();
    return Scaffold(
      appBar: AppBar(
          //centerTitle: true,
          title: Text(
            'Address',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 20,
          actionsIconTheme: IconThemeData(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
              Padding(padding: EdgeInsets.all(20.0)),
              Divider(thickness: 15),
              ListTile(
                  subtitle: Text('$address_type',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.bold)),
                  title: Text('$name',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              Text('    $address',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Text('    $town',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Text('    $city',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Text('    $pincode',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Text('    $state',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              ListTile(
                  title: Row(children: <Widget>[
                Text('Mobile: '),
                Text("$mob", style: TextStyle(fontWeight: FontWeight.bold))
              ])),
              ListTile(
                  title: Row(children: <Widget>[
                Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18.0,
                    runSpacing: 18.0,
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAddress(),
                              ));
                        },
                        text: "EDIT ADDRESS",
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline2x,
                        size: GFSize.LARGE,
                        color: Colors.black,
                      ),
                      GFButton(
                        onPressed: () {
                          CollectionReference usersaddress = FirebaseFirestore
                              .instance
                              .collection('USER ADDRESS');
                          usersaddress
                              .doc(uid)
                              .delete()
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Address(),
                                  )))
                              .catchError((error) => Toast.show(
                                  "Error: $error", context,
                                  duration: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.grey[300],
                                  gravity: Toast.BOTTOM));
                        },
                        text: "DELETE ADDRESS",
                        shape: GFButtonShape.square,
                        type: GFButtonType.outline2x,
                        size: GFSize.LARGE,
                        color: Colors.black,
                      ),
                    ]),
              ])),
              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 8.75,
              ),
              Container(
                color: Colors.grey[200],
                child: Container(
                    child: Text(
                  '  DELIVERY ESTIMATES',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
                width: MediaQuery.of(context).size.width,
                height: 19,
              ),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 8.75,
              ),
              ListTile(
                  title: Row(children: <Widget>[
                Text('Estimated delivery by '),
                Text("$formattedDate",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ])),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 8.75,
              ),
              Container(
                color: Colors.grey[200],
                child: Container(
                    child: Text(
                  '  PRICE DETAILS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
                width: MediaQuery.of(context).size.width,
                height: 19,
              ),
              Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 8.75,
              ),
              ListTile(
                  leading: Icon(Icons.countertops),
                  title: Text('Number of items: ${values.length}',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ))),
              ListTile(
                  leading: Text('₹',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.grey[600])),
                  title: Row(children: <Widget>[
                    Text('Total Cost: '),
                    Text("$ftcost",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ]))
            ])),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 300.0,
        child: Container(
            height: 60,
            child: ListTile(
              leading: Text('$ftcost',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              title: SizedBox(
                  height: 50,
                  width: 800,
                  child: GFButton(
                    elevation: 100,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentMethod(),
                          ));
                    },
                    text: "CONTINUE",
                    textStyle: TextStyle(fontSize: 18.0),
                    shape: GFButtonShape.square,
                    color: Colors.red,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
            )),
        color: Colors.white,
      ),
    );
  }
}
