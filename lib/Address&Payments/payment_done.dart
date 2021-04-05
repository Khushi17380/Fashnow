import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/FirstScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentDone extends StatefulWidget {
  PaymentDone(
      {@required this.items,
      this.totalcost,
      this.deliverycode,
      this.name,
      this.mob,
      this.address,
      this.pincode,
      this.town,
      this.city,
      this.state,
      // ignore: non_constant_identifier_names
      this.address_type});
  final items;
  final totalcost;
  final deliverycode;
  final name;
  final mob;
  final address;
  final pincode;
  final town;
  final city;
  final state;
  // ignore: non_constant_identifier_names
  final address_type;
  @override
  _PaymentDoneState createState() {
    return _PaymentDoneState(items, totalcost, deliverycode, name, mob, address,
        pincode, town, city, state, address_type);
  }
}

class _PaymentDoneState extends State<PaymentDone> {
  final items;
  final totalcost;
  final deliverycode;
  final name;
  final mob;
  final address;
  final pincode;
  final town;
  final city;
  final state;
  // ignore: non_constant_identifier_names
  final address_type;
  _PaymentDoneState(
      this.items,
      this.totalcost,
      this.deliverycode,
      this.name,
      this.mob,
      this.address,
      this.pincode,
      this.town,
      this.city,
      this.state,
      this.address_type);
  CollectionReference users =
      FirebaseFirestore.instance.collection('USER CART');

  Future<void> deleteUserCart() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    return users.doc(uid).delete();
  }

  @override
  Widget build(BuildContext context) {
    deleteUserCart();
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'CONFIRMATION',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 20,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())))),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset('assets/tick.gif',
                              height: 100, width: 100),
                          Text('Congratulations!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text('Your Order has been Placed'),
                          Padding(padding: EdgeInsets.all(8.0)),
                          Text('Your Delivery Code is: $deliverycode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Padding(padding: EdgeInsets.all(10.0)),
                        ],
                      ),
                    )),
              ),
              Text('    Total Cost: $totalcost',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  )),
              Text('    Number of items: $items',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  )),
              Padding(padding: EdgeInsets.all(10.0)),
              Text('   Shipping To-',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.all(8.0)),
              Text("    $name",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[700])),
              Text("    $address", style: TextStyle(color: Colors.grey[700])),
              Text("    $town", style: TextStyle(color: Colors.grey[700])),
              Text("    $city", style: TextStyle(color: Colors.grey[700])),
              Text("    $pincode", style: TextStyle(color: Colors.grey[700])),
              Text("    $state", style: TextStyle(color: Colors.grey[700])),
              Text("    $address_type",
                  style: TextStyle(color: Colors.grey[700])),
              Padding(padding: EdgeInsets.all(8.0)),
              Text("    $mob", style: TextStyle(fontWeight: FontWeight.bold)),
            ])));
  }
}
