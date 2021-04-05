import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import 'address_details.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  // ignore: non_constant_identifier_names
  String name, address, town, city, pincode, state, mob, address_type;
  bool _isopenonsaturday, _isopenonsunday;

  void makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var extractdata = jsonDecode(response.body);
    if (extractdata[0]['Message'] != "No records found") {
      setState(() {
        _iserror = false;
        _isLoading = false;
        localities = [];
        estate.text = extractdata[0]['PostOffice'][0]['Circle'];
        ecity.text = extractdata[0]['PostOffice'][0]['Division'];
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
        ecity.clear();
        estate.clear();
      });
    }
  }

  List _saveas = ["HOME", "WORK"];
  var __saveasvalue;
  bool _autoValidate = false;
  String url = "";
  var _value;
  bool _isLoading = false;
  bool _iserror = false;
  final _formKey = GlobalKey<FormState>();
  List localities = [];

  TextEditingController ename = TextEditingController();
  TextEditingController emob = TextEditingController();
  TextEditingController epin = TextEditingController();
  TextEditingController eaddress = TextEditingController();
  TextEditingController etown = TextEditingController();
  TextEditingController ecity = TextEditingController();
  TextEditingController estate = TextEditingController();

  @override
  void initState() {
    super.initState();
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
        // _isopenonsaturday = doc.data()['Open on Saturday'];
        //_isopenonsunday = doc.data()['Open on Sunday'];
        // _isopenonsaturday = true;
        //_isopenonsunday = true;
        ename.text = '$name';
        emob.text = '$mob';
        epin.text = '$pincode';
        eaddress.text = '$address';
        etown.text = '$town';
        ecity.text = '$city';
        estate.text = '$state';
        url = 'https://api.postalpincode.in/pincode/$pincode';
        makeRequest();
        if (address_type == 'HOME') {
          __saveasvalue = 0;
          _isopenonsaturday = false;
          _isopenonsunday = false;
        } else {
          __saveasvalue = 1;
          _isopenonsaturday = doc.data()['Open on Saturday'];
          _isopenonsunday = doc.data()['Open on Sunday'];
        }
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

    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'Edit Address',
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
                      controller: ename,
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
                      controller: emob,
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
                      controller: epin,

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
                      controller: eaddress,
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
                      controller: etown,
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
                                                      etown.text = _value;
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
                            controller: ecity,
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
                          controller: estate,
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
                            'Name': ename.text,
                            'Mobile Number': emob.text,
                            'Pincode': epin.text,
                            'Address': eaddress.text,
                            'Locality': etown.text,
                            'State': estate.text,
                            'City': ecity.text,
                            'Address Type': _saveas[__saveasvalue],
                            'Open on Saturday':
                                __saveasvalue == 1 ? _isopenonsaturday : null,
                            'Open on Sunday':
                                __saveasvalue == 1 ? _isopenonsunday : null
                          }) //////////USER ADDRESS///////
                          .then((value) => Navigator.pop(context))
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
                    'UPDATE ADDRESS',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ))));
  }
}
