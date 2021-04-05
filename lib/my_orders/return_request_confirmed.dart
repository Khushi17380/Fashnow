import 'package:flutter/material.dart';

class ReturnRequest extends StatefulWidget {
  final image1;
  final name;
  final size;
  final refcode;
  ReturnRequest({@required this.image1, this.name, this.size, this.refcode});
  @override
  _ReturnRequestState createState() {
    return _ReturnRequestState(image1, name, size, refcode);
  }
}

class _ReturnRequestState extends State<ReturnRequest> {
  final image1;
  final name;
  final size;
  final refcode;
  _ReturnRequestState(this.image1, this.name, this.size, this.refcode);
  @override
  Widget build(BuildContext context) {
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
                          Image.asset('assets/redtick.png',
                              height: 100, width: 100),
                          Text('Return Request submitted',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red)),
                          Padding(padding: EdgeInsets.all(8.0)),
                          Text('Your Reference Code is: $refcode',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Padding(padding: EdgeInsets.all(10.0)),
                          Image.network(image1, height: 100, width: 100),
                          Padding(padding: EdgeInsets.all(8.0)),
                          Text(name),
                          Text("Size: $size")
                        ],
                      ),
                    )),
              ),
            ])));
  }
}
