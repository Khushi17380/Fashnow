import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/Address&Payments/address_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:toast/toast.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List _saveas = ["HOME", "WORK"];
  var __saveasvalue = 0;
  bool _autoValidate = false;
  String url = "";
  var _value;
  bool _isLoading = true;
  bool _iserror = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  List localities = [];
  bool _isopenonsaturday = false;
  bool _isopenonsunday = false;

  void makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var extractdata = jsonDecode(response.body);
    if (extractdata[0]['Message'] != "No records found") {
      setState(() {
        _iserror = false;
        _isLoading = false;
        localities = [];
        state.text = extractdata[0]['PostOffice'][0]['Circle'];
        city.text = extractdata[0]['PostOffice'][0]['Division'];
        int i = 0;
        while (i != extractdata[0]['PostOffice'].length) {
          var data = extractdata[0]['PostOffice'][i]['Name'];
          localities.add(data);
          i++;
        }
      });
    } else {
      print(extractdata[0]['Message']);
      setState(() {
        _iserror = true;
        _isLoading = true;
        localities = [];
        city.clear();
        state.clear();
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
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'Add Address',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 20,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        body: Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                      '  CONTACT DETAILS',
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
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
                      ],
                      decoration: InputDecoration(
                        labelText: "Name",
                        icon: Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: mob,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: "Mobile No.",
                        icon: Icon(Icons.phone_iphone),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Mobile Number';
                        } else if (value.length < 10) {
                          return 'Minimum length is 10';
                        } else if ((value.startsWith('1')) ||
                            (value.startsWith('2')) ||
                            (value.startsWith('3')) ||
                            (value.startsWith('4')) ||
                            (value.startsWith('5'))) {
                          return "Please enter a valid 10 digit mobile number";
                        }
                        return null;
                      },
                    ),
                  ),
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
                      '  ADDRESS',
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
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: pin,

                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        counterText: "Please click '✓' button",
                        errorText:
                            _iserror ? "Please enter valid pincode" : null,
                        suffix: _isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                                height: 16.0,
                                width: 16.0,
                              )
                            : null,
                        labelText: "Pin Code",
                        icon: Icon(Icons.pin_drop),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),

                      onFieldSubmitted: (value) {
                        url = 'https://api.postalpincode.in/pincode/$value';
                        makeRequest();
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Pin Code';
                        } else if (value.length < 6) {
                          return 'Minimum length is 6';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: address,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[0-9a-zA-Z/.(),'#;:°@-_ ]")),
                      ],
                      decoration: InputDecoration(
                        labelText: "Address(House No, Building, Street,Area)",
                        icon: Icon(Icons.house),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Address';
                        } else if (!(value.contains(new RegExp(r'[0-9]'))) ||
                            !(value.contains(new RegExp(r'[a-zA-z]')))) {
                          return 'Please add house number,street or landmark details';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: town,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Locality/ Town",
                        hintText: "$_value",
                        icon: Icon(Icons.location_city_rounded),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context, StateSetter state) {
                                return Container(
                                    height: 400,
                                    child: SingleChildScrollView(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                          const ListTile(
                                              title: Text('Select Locality',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Column(children: <Widget>[
                                            for (int i = 0;
                                                i < localities.length;
                                                i++)
                                              ListTile(
                                                title: Text(
                                                  localities[i],
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                leading: Radio(
                                                  value: localities[i],
                                                  groupValue: _value,
                                                  activeColor:
                                                      Color(0xFF6200EE),
                                                  onChanged: (var value) {
                                                    state(() {
                                                      _value = value;
                                                      print(_value);
                                                    });
                                                    setState(() {
                                                      _value = _value;
                                                      town.text = _value;
                                                    });
                                                  },
                                                ),
                                              ),
                                          ])
                                        ])));
                              });
                            });
                      },
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Locality /Town';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          height: 52,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            controller: city,
                            readOnly: true,
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: "City/District",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        height: 52,
                        width: MediaQuery.of(context).size.width * 0.48,
                        child: TextField(
                          controller: state,
                          readOnly: true,
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "State",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
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
                      '  SAVE ADDRESS AS',
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
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 18.0,
                      runSpacing: 18.0,
                      children: List<Widget>.generate(
                        2,
                        (int index) {
                          return ChoiceChip(
                            padding: EdgeInsets.all(10.0),
                            label: Text(_saveas[index]),
                            labelStyle: TextStyle(color: Colors.black),
                            selected: __saveasvalue == index,
                            avatarBorder: CircleBorder(),
                            selectedColor: Colors.pink[200],
                            shape: StadiumBorder(
                                side: BorderSide(color: Colors.black)),
                            backgroundColor: Colors.white,
                            onSelected: (bool selected) {
                              setState(() {
                                __saveasvalue = selected ? index : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    )
                  ])),
                  Column(children: <Widget>[
                    if (__saveasvalue == 1)
                      Column(children: <Widget>[
                        ListTile(
                            title: Text("Open On Saturday"),
                            leading: Checkbox(
                              activeColor: Colors.pink,
                              value: _isopenonsaturday,
                              onChanged: (value) {
                                setState(() {
                                  _isopenonsaturday = value;
                                });
                                print("Saturday open:$_isopenonsaturday");
                              },
                            )),
                        ListTile(
                            title: Text("Open On Sunday"),
                            leading: Checkbox(
                              activeColor: Colors.pink,
                              value: _isopenonsunday,
                              onChanged: (value) {
                                setState(() {
                                  _isopenonsunday = value;
                                });
                                print("Sunday open:$_isopenonsunday");
                              },
                            ))
                      ])
                  ]),
                  Divider(thickness: 10)
                ]))),
        bottomNavigationBar: BottomAppBar(
            child: SizedBox(
                height: 50.0,
                width: 200.0,
                child: RaisedButton(
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  elevation: 5,
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      _formKey.currentState.save();
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final User user = auth.currentUser;
                      final uid = user.uid;
                      CollectionReference useraddress =
                          FirebaseFirestore.instance.collection('USER ADDRESS');
                      useraddress
                          .doc(uid)
                          .set({
                            'Name': name.text,
                            'Mobile Number': mob.text,
                            'Pincode': pin.text,
                            'Address': address.text,
                            'Locality': town.text,
                            'State': state.text,
                            'City': city.text,
                            'Address Type': _saveas[__saveasvalue],
                            'Open on Saturday':
                                __saveasvalue == 1 ? _isopenonsaturday : null,
                            'Open on Sunday':
                                __saveasvalue == 1 ? _isopenonsunday : null
                          }) //////////USER ADDRESS///////
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddressDetails(),
                              )))
                          .catchError((error) => Toast.show(
                              "Error: $error", context,
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
                  child: Text(
                    'Add Address',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ))));
  }
}
