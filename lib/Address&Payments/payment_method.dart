import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/Address&Payments/payment_done.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:random_string/random_string.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  List<Map<dynamic, dynamic>> values = [];
  double tcost;
  String ftcost;
  var format = NumberFormat.currency(locale: 'HI');
  var paytype;

  Future<void> readCartData() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER CART').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        values = List.from(doc.data()['Cart']);
      });
    });
  }

  Future<void> dialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Currently Not Available'),
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

  String name,
      address,
      town,
      city,
      pincode,
      state,
      mob,
      // ignore: non_constant_identifier_names
      address_type,
      // ignore: non_constant_identifier_names
      open_on_sat,
      // ignore: non_constant_identifier_names
      open_on_sun;
  Future<void> readAddress() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER ADDRESS').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        name = doc.data()['Name'];
        address = doc.data()['Address'];
        town = doc.data()['Locality'];
        city = doc.data()['City'];
        pincode = doc.data()['Pincode'];
        state = doc.data()['State'];
        mob = doc.data()['Mobile Number'];
        address_type = doc.data()['Address Type'];
        open_on_sat = doc.data()['Open on Saturday'];
        open_on_sun = doc.data()['Open on Sunday'];
      });
    });
  }

  var deliverycode;
  Future<void> random() async {
    setState(() {
      deliverycode = randomAlphaNumeric(4);
    });
  }

  Future<void> placeorder() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final uid = user.uid;
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    var fullDate = formatter.format(now);

    var formatdate = new DateFormat('dd');
    var date = formatdate.format(now);

    var formatmonth = new DateFormat('MM');
    var month = formatmonth.format(now);

    var formatyear = new DateFormat('yyyy');
    var year = formatyear.format(now);

    var est = new DateTime.now().add(Duration(days: 7, hours: 10));
    // ignore: non_constant_identifier_names
    var estimated_delivery_by = formatter.format(est);
    //Map<String, dynamic> orderof;
    //for (int index = 0; index < values.length; index++) {

    CollectionReference order = FirebaseFirestore.instance.collection('ORDER');
    var d = deliverycode;

    QuerySnapshot _myDoc =
        // ignore: deprecated_member_use
        await Firestore.instance.collection('ORDER').getDocuments();
    // ignore: deprecated_member_use
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    var no = _myDocCount.length;
    String noo = no.toString();

    order.doc(noo).set({
      'Full Date': fullDate,
      'Date': date,
      'Month': month,
      'Year': year,
      'Order': values,
      'Name': name,
      'Mobile Number': mob,
      'Pincode': pincode,
      'Address': address,
      'Locality': town,
      'State': state,
      'City': city,
      'Address Type': address_type,
      'Open on Saturday': open_on_sat,
      'Open on Sunday': open_on_sun,
      'Status': 'Not yet Delivered',
      'Estimated Delivery By': estimated_delivery_by,
      'Payment Type': paytype,
      'Total Cost': ftcost,
      'Delivery Code': deliverycode,
      'User Id': uid,
      'Order Number': no
    }) //////////ORDER///////
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentDone(
              items: values.length,
              totalcost: ftcost,
              deliverycode: d,
              name: name,
              mob: mob,
              address: address,
              pincode: pincode,
              city: city,
              town: town,
              state: state,
              address_type: address_type,
            ),
          ));
      // ignore: deprecated_member_use
    }).catchError((error) => Toast.show("Error: $error", context,
            duration: Toast.LENGTH_SHORT,
            backgroundColor: Colors.grey[300],
            gravity: Toast.BOTTOM));
    //}

//////////////////USER ORDER///////////////////////////////////////

    Map<String, dynamic> myorder;

    myorder = {
      'Order_values': values,
      'Order Date': fullDate,
      'Status': 'Not Yet Delivered',
      'Delivery Code': deliverycode,
      'Order Number': no,
      'Delivered on': "",
      'Rdd': 0,
      'Rmm': 0,
      'Ryy': 0
    };
    CollectionReference userorder =
        FirebaseFirestore.instance.collection('USER ORDER');

    userorder.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userorder.doc(uid).update({
          'User Order': FieldValue.arrayUnion([myorder]),
        });
        print('exists');
      } else {
        userorder.doc(uid).set({
          'User Order': FieldValue.arrayUnion([myorder]),
        });
        print('not exists');
      }
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
    readCartData();
    findtcost();
    readAddress();
    random();
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'Payment',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 5,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              color: Colors.purple[400],
              child: Center(
                  child: Text(
                'SECURE PAYMENTS',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
              width: MediaQuery.of(context).size.width,
              height: 56,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              height: 9.75,
            ),
            Container(
              color: Colors.grey[200],
              child: Container(
                  child: Text(
                '  PAYMENT METHODS',
                textAlign: TextAlign.left,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )),
              width: MediaQuery.of(context).size.width,
              height: 19,
            ),
            Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              height: 9.75,
            ),
            Padding(padding: EdgeInsets.all(5.0)),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      setState(() {
                        paytype = 'Pay on Delivery';
                      });
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                    ListTile(
                                        leading: Text('Number of items:'),
                                        title: Text('${values.length}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ))),
                                    ListTile(
                                        leading: Text('Payment Type:'),
                                        title: Text('$paytype',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )))
                                  ])),
                              title: Text('Total Cost: $ftcost'),
                              actions: <Widget>[
                                SizedBox(
                                    height: 50,
                                    width: 800,
                                    child: GFButton(
                                      elevation: 100,
                                      onPressed: () {
                                        placeorder();
                                      },
                                      text: "PLACE ORDER",
                                      textStyle: TextStyle(fontSize: 18.0),
                                      shape: GFButtonShape.square,
                                      color: Colors.red,
                                      buttonBoxShadow: true,
                                      size: GFSize.LARGE,
                                    )),
                              ],
                            );
                          });
                    }),
                leading: Text(
                  'PAY ON DELIVERY(CASH/CARD/UPI)',
                )),
            Divider(),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      dialog();
                    }),
                leading: Text(
                  'CREDIT/DEBIT CARD                            ',
                )),
            Divider(),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      dialog();
                    }),
                leading: Text(
                  'PHONEPE/GOOGLE PAY/BHIM UPI   ',
                )),
            Divider(),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      dialog();
                    }),
                leading: Text(
                  'PAYTM/PAYZAPP/WALLETS              ',
                )),
            Divider(),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      dialog();
                    }),
                leading: Text(
                  'NET BANKING                                      ',
                )),
            Divider(),
            ListTile(
                title: FlatButton(
                    child: Text('SELECT', style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      dialog();
                    }),
                leading: Text(
                  'EMI                                                         ',
                )),
            Divider(),
          ]),
        ));
  }
}
