import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/Address&Payments/edit_address.dart';
import 'package:fashnow_/my_orders/return_request_confirmed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:random_string/random_string.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class ReturnItem extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final product_id;
  final image1;
  final name;
  final db;
  final cost;
  final pp;
  // ignore: non_constant_identifier_names
  final order_date;
  // ignore: non_constant_identifier_names
  final order_no;
  final size;
  final arrayindex;
  final arrayindexx;
  // ignore: non_constant_identifier_names

  ReturnItem(
      {@required this.db,
      this.name,
      this.cost,
      this.image1,
      // ignore: non_constant_identifier_names
      this.product_id,
      this.pp,
      // ignore: non_constant_identifier_names
      this.order_date,
      // ignore: non_constant_identifier_names
      this.order_no,
      this.size,
      // ignore: non_constant_identifier_names
      this.arrayindex,
      this.arrayindexx});
  @override
  _ReturnItemState createState() {
    return _ReturnItemState(db, name, cost, image1, product_id, pp, order_date,
        order_no, size, arrayindex, arrayindexx);
  }
}

class _ReturnItemState extends State<ReturnItem> {
  // ignore: non_constant_identifier_names
  final product_id;
  final image1;
  final name;
  final db;
  final cost;
  final pp;
  // ignore: non_constant_identifier_names
  final order_date;
  // ignore: non_constant_identifier_names
  final order_no;
  // ignore: non_constant_identifier_names
  final size;
  final arrayindex;
  final arrayindexx;
  // ignore: non_constant_identifier_names

  _ReturnItemState(
      this.db,
      this.name,
      this.cost,
      this.image1,
      this.product_id,
      this.pp,
      this.order_date,
      this.order_no,
      this.size,
      this.arrayindex,
      this.arrayindexx);
  var _value;
  var __value;
  var acctype;

  String pname,
      address,
      town,
      city,
      pincode,
      state,
      mob,
      // ignore: non_constant_identifier_names
      address_type,
      _isopenonsaturday,
      _isopenonsunday;
  var uid;
  Future<void> readAddress() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    uid = user.uid;
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER ADDRESS').document(uid);
    query.snapshots().forEach((doc) {
      if (this.mounted) {
        setState(() {
          pname = doc.data()['Name'];
          address = doc.data()['Address'];
          town = doc.data()['Locality'];
          city = doc.data()['City'];
          pincode = doc.data()['Pincode'];
          state = doc.data()['State'];
          mob = doc.data()['Mobile Number'];
          address_type = doc.data()['Address Type'];
          _isopenonsaturday = doc.data()['Open on Saturday'];
          _isopenonsunday = doc.data()['Open on Sunday'];
        });
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  TextEditingController comment = TextEditingController();
  TextEditingController cusname = TextEditingController();
  TextEditingController acc = TextEditingController();
  TextEditingController reacc = TextEditingController();
  TextEditingController ifsc = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController branchname = TextEditingController();
  bool validate1;
  bool validate2;

// ignore: non_constant_identifier_names
  List<Map<dynamic, dynamic>> user_order = [];

  Future<void> readOrder() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER ORDER').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        user_order = List.from(doc.data()['User Order']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readAddress();
    readOrder();
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'Return Item',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 5,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        body: Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                  Padding(padding: EdgeInsets.all(5.0)),
                  ListTile(
                      title: Row(children: <Widget>[
                    Text('Placed On: '),
                    Text("$order_date",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Container(
                      child: Row(children: <Widget>[
                    Text('   Order Number: ', style: TextStyle(fontSize: 15)),
                    Text("$order_no",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Container(
                      child: Row(children: <Widget>[
                    Text('    Payment Mode: ', style: TextStyle(fontSize: 15)),
                    Text("Pay On Delivery",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Divider(thickness: 5),
                  GFCard(
                      color: Colors.red[100],
                      title: GFListTile(
                        avatar: GFAvatar(
                            backgroundImage: NetworkImage(image1),
                            shape: GFAvatarShape.standard),
                        title: Text(name,
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600)),
                        subTitle: Text(cost),
                      ),
                      content: Text('Size: $size')),
                  Container(
                      child: Row(children: <Widget>[
                    Text('    Valid before: ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    Text("$pp", style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Container(
                      child: Row(children: <Widget>[
                    Text('    Refund Amount: ',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    Text("$cost", style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
                  Divider(thickness: 5),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text("Please tell the reason for return",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Text('This iformation is only used to improve our service.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400)),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text("  Select Issue -",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 17,
                          color: Colors.grey[850])),
                  Column(children: <Widget>[
                    ListTile(
                      title: Text(
                        'Received a wrong or defective product',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value: 'Received a wrong or defective product',
                        groupValue: _value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            _value = value;
                            print(_value);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Image shown did not match with the actual product',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value:
                            'Image shown did not match with the actual product',
                        groupValue: _value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            _value = value;
                            print(_value);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Quality Issue',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value: 'Quality Issue',
                        groupValue: _value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            _value = value;
                            print(_value);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'I change my mind',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value: 'I change my mind',
                        groupValue: _value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            _value = value;
                            print(_value);
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Size or fit issue',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value: 'Size or fit issue',
                        groupValue: _value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            _value = value;
                            print(_value);
                          });
                        },
                      ),
                    )
                  ]),
                  Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                          minLines: 2,
                          maxLines: null,
                          controller: comment,
                          decoration: InputDecoration(
                            labelText: "Additional Comment",
                            icon: Icon(Icons.comment),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Comment';
                            }

                            return null;
                          })),
                  Divider(thickness: 5),
                  Padding(padding: EdgeInsets.all(5)),
                  Text("  Address for pickup",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  ListTile(
                      subtitle: Text('$address_type',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.bold)),
                      title: Text('$pname',
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
                      leading: GFButton(
                    elevation: 100,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditAddress(),
                          ));
                    },
                    text: "Edit Address",
                    textStyle: TextStyle(fontSize: 16.0, color: Colors.blue),
                    shape: GFButtonShape.square,
                    type: GFButtonType.outline2x,
                    color: Colors.blue,
                    buttonBoxShadow: true,
                    size: GFSize.LARGE,
                  )),
                  Divider(thickness: 5),
                  Padding(padding: EdgeInsets.all(5)),
                  Text("  Mode of refund",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                  Column(children: <Widget>[
                    ListTile(
                      title: Text(
                        'Bank Account',
                        style: TextStyle(color: Colors.black),
                      ),
                      leading: Radio(
                        value: 'Bank Account',
                        groupValue: __value,
                        activeColor: Color(0xFF6200EE),
                        onChanged: (var value) {
                          setState(() {
                            __value = value;
                            print(__value);
                          });
                        },
                      ),
                    ),
                    Column(children: <Widget>[
                      if (__value == "Bank Account")
                        Column(children: <Widget>[
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: cusname,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z ]'))
                                  ],
                                  decoration: InputDecoration(
                                    labelText:
                                        "Customer Name(as per the bank records)",
                                    icon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Customer Name';
                                    }
                                    return null;
                                  })),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: acc,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(18),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Account Number",
                                    icon: Icon(Icons.account_balance),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Account Number';
                                    }
                                    if (value.length < 9 || value.length > 18) {
                                      return 'Enter Correct Account Number';
                                    }

                                    return null;
                                  })),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: reacc,
                                  obscureText: true,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(18),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Re-enter Account Number",
                                    icon: Icon(Icons.account_balance),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Account Number';
                                    }
                                    if (value.length < 9 || value.length > 18) {
                                      return 'Enter Correct Account Number';
                                    }

                                    return null;
                                  })),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: ifsc,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9 ]')),
                                    LengthLimitingTextInputFormatter(11)
                                  ],
                                  decoration: InputDecoration(
                                    labelText: "Bank IFSC Code",
                                    icon: Icon(Icons.account_balance),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter IFSC Code';
                                    }
                                    if (value.length != 11 || value[4] != "0") {
                                      return 'Enter Correct IFSC Code';
                                    }

                                    return null;
                                  })),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: bankname,
                                  decoration: InputDecoration(
                                    labelText: "Bank Name",
                                    icon: Icon(Icons.account_balance),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Bank Name';
                                    }
                                    return null;
                                  })),
                          Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: TextFormField(
                                  controller: branchname,
                                  decoration: InputDecoration(
                                    labelText: "Branch Name",
                                    icon: Icon(Icons.account_balance),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter Branch Name';
                                    }
                                    return null;
                                  })),
                          ListTile(
                              title: Text("Account Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))),
                          ListTile(
                            title: Text(
                              'Savings',
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: Radio(
                              value: 'Savings',
                              groupValue: acctype,
                              activeColor: Color(0xFF6200EE),
                              onChanged: (var value) {
                                setState(() {
                                  acctype = value;
                                  print(acctype);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'Current',
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: Radio(
                              value: 'Current',
                              groupValue: acctype,
                              activeColor: Color(0xFF6200EE),
                              onChanged: (var value) {
                                setState(() {
                                  acctype = value;
                                  print(acctype);
                                });
                              },
                            ),
                          )
                        ])
                    ])
                  ])
                ])))),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              child: Row(children: <Widget>[
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                  elevation: 100,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "CANCEL",
                  textStyle: TextStyle(fontSize: 18.0, color: Colors.black),
                  shape: GFButtonShape.square,
                  color: Colors.white,
                  buttonBoxShadow: true,
                  size: GFSize.LARGE,
                )),
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: GFButton(
                  elevation: 100,
                  onPressed: () {
                    if (acctype == null || __value == null || _value == null) {
                      validate1 = false;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Please Select Value's from Radio Buttons"),
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
                    } else {
                      validate1 = true;
                    }
                    if (acc.text != reacc.text) {
                      validate2 = false;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "Account Number don't match...\nPlease check again."),
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
                    } else {
                      validate2 = true;
                    }
                    if (_formKey.currentState.validate() &&
                        validate1 == true &&
                        validate2 == true) {
                      var refno;

                      refno = randomNumeric(10);
                      CollectionReference userorder =
                          FirebaseFirestore.instance.collection('USER ORDER');

                      user_order[arrayindex]['Order_values'][arrayindexx]
                              ['Cart_Order'] =
                          'Return Request Submitted-Ref.No($refno)';
                      userorder.doc(uid).update({'User Order': user_order});
                      /////////////////////////////////////////////////////
                      CollectionReference returnrequest = FirebaseFirestore
                          .instance
                          .collection('RETURN REQUEST');
                      returnrequest
                          .doc()
                          .set({
                            'Product Id': product_id,
                            'Image': image1,
                            'Db': db,
                            'Cost': cost,
                            'Ordered Date': order_date,
                            'Order Number': order_no,
                            'Size': size,
                            'Product Name': name,
                            'Customer Name': pname,
                            'Address': address,
                            'Mobile': mob,
                            'City': city,
                            'Town': town,
                            'Pincode': pincode,
                            'Address Type': address_type,
                            'Open on Saturday': _isopenonsaturday,
                            'Open on Sunday': _isopenonsunday,
                            'State': state,
                            'Bank Customer Name': cusname.text,
                            'Bank Account Number': acc.text,
                            'Bank IFSC Code': ifsc.text,
                            'Bank Name': bankname.text,
                            'Bank Branch Name': branchname.text,
                            'Uid': uid,
                            'Reference Number': refno,
                            'Returned': "Not Yet"
                          }) //////////USER RETURN REQUEST///////
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReturnRequest(
                                  image1: image1,
                                  name: name,
                                  size: size,
                                  refcode: refno,
                                ),
                              )))
                          .catchError((error) => Toast.show(
                              "Error in requesting return: $error", context,
                              duration: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.grey[300],
                              gravity: Toast.BOTTOM));
                    } else {
                      //    If all data are not valid then start auto validation.
                      setState(() {
                        _autoValidate = true;
                      });
                    }
                  },
                  text: "CONFIRM",
                  textStyle: TextStyle(fontSize: 18.0),
                  shape: GFButtonShape.square,
                  color: Colors.red,
                  buttonBoxShadow: true,
                  size: GFSize.LARGE,
                )),
          ])),
        ));
  }
}
