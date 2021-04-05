import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/my_orders/order&cartview.dart';
import 'package:fashnow_/my_orders/return_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:toast/toast.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;

class _MyOrderState extends State<MyOrder> {
  var now = DateTime.now();
  var pp;

  // ignore: non_constant_identifier_names
  List<Map<dynamic, dynamic>> user_order = [];
  // ignore: non_constant_identifier_names
  int all_torder = 0;
  Future<void> readOrder() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER ORDER').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        user_order = List.from(doc.data()['User Order']);
        all_torder = user_order.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readOrder();
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'My Order/s',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            elevation: 5,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black)),
        body: ListView.builder(
            itemCount: all_torder,
            itemBuilder: (context, index) {
              pp = DateTime.utc(user_order[index]['Ryy'],
                  user_order[index]['Rmm'], user_order[index]['Rdd']);
              return Container(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                    Padding(padding: EdgeInsets.all(10.0)),
                    ExpansionTile(
                        leading: Image.network(
                            "${user_order[index]['Order_values'][0]['Cart_Image1']}"),
                        title: Text(
                          'Ordered Number: ${user_order[index]['Order Number']}',
                        ),
                        subtitle: Column(children: <Widget>[
                          Text(
                            'Ordered On: ${user_order[index]['Order Date']}',
                          ),
                          Text(
                              'Status: ${user_order[index]['Status']} on ${user_order[index]['Delivered on']}'),
                          Text(
                              "No.of items: ${user_order[index]['Order_values'].length}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          if ("${user_order[index]['Status']}" ==
                              'Not Yet Delivered')
                            Text(
                                "Delivery Code: ${user_order[index]['Delivery Code']}",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.all(10.0)),
                        ]),
                        children: <Widget>[
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  user_order[index]['Order_values'].length,
                              itemBuilder: (context, indexx) {
                                return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OPpg(
                                                  db: "${user_order[index]['Order_values'][indexx]['Cart_Db']}",
                                                  product_code:
                                                      "${user_order[index]['Order_values'][indexx]['Cart_Product_Code']}",
                                                )),
                                      );
                                    },
                                    leading: Image.network(
                                      "${user_order[index]['Order_values'][indexx]['Cart_Image1']}",
                                      width: 50,
                                      height: 200,
                                    ),
                                    title: Column(children: <Widget>[
                                      Padding(padding: EdgeInsets.all(10.0)),
                                      Text(
                                          'Name: ${user_order[index]['Order_values'][indexx]['Cart_Name']}'),
                                      Text(
                                          'Cost: ${user_order[index]['Order_values'][indexx]['Cart_Cost']}'),
                                      Text(
                                          'Size: ${user_order[index]['Order_values'][indexx]['Cart_Size']}'),
                                      if ("${user_order[index]['Order_values'][indexx]['Cart_Order']}" ==
                                          'Cancelled')
                                        Text('ORDER CANCELLED',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ///////////////////////////////////////
                                      if ("${user_order[index]['Status']}" ==
                                              'Delivered' &&
                                          "${user_order[index]['Order_values'][indexx]['Cart_Order']}" !=
                                              'Cancelled' &&
                                          now.toUtc().isBefore(pp) &&
                                          !"${user_order[index]['Order_values'][indexx]['Cart_Order']}"
                                              .startsWith(
                                                  "Return Request Submitted") &&
                                          "${user_order[index]['Order_values'][indexx]['Cart_Order']}" !=
                                              "Returned")
                                        GFButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReturnItem(
                                                    arrayindex: index,
                                                    arrayindexx: indexx,
                                                    db: user_order[index]
                                                            ['Order_values']
                                                        [indexx]['Cart_Db'],
                                                    name: user_order[index]
                                                            ['Order_values']
                                                        [indexx]['Cart_Name'],
                                                    cost: user_order[index]
                                                            ['Order_values']
                                                        [indexx]['Cart_Cost'],
                                                    image1: user_order[index]
                                                            ['Order_values']
                                                        [indexx]['Cart_Image1'],
                                                    product_id: user_order[
                                                                    index]
                                                                ['Order_values']
                                                            [indexx]
                                                        ['Cart_Product_Code'],
                                                    pp: pp,
                                                    order_date:
                                                        user_order[index]
                                                            ['Order Date'],
                                                    order_no: user_order[index]
                                                        ['Order Number'],
                                                    size: user_order[index]
                                                            ['Order_values']
                                                        [indexx]['Cart_Size'],
                                                  ),
                                                ));
                                          },
                                          text: "RETURN ORDER",
                                          shape: GFButtonShape.square,
                                          type: GFButtonType.outline2x,
                                          size: GFSize.LARGE,
                                          color: Colors.black,
                                        ),
                                      /////////////////////////////////////////////////
                                      if ("${user_order[index]['Order_values'][indexx]['Cart_Order']}"
                                          .startsWith(
                                              "Return Request Submitted"))
                                        Text(
                                            "${user_order[index]['Order_values'][indexx]['Cart_Order']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      /////////////////////////////////////////////////
                                      if ("${user_order[index]['Order_values'][indexx]['Cart_Order']}" ==
                                          "Returned")
                                        Text(
                                            "${user_order[index]['Order_values'][indexx]['Cart_Order']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ////////////////////////////////////////////////
                                      if ("${user_order[index]['Status']}" ==
                                              'Not Yet Delivered' &&
                                          "${user_order[index]['Order_values'][indexx]['Cart_Order']}" !=
                                              'Cancelled')
                                        GFButton(
                                          onPressed: () {
                                            user_order[index]['Order_values']
                                                    [indexx]['Cart_Order'] =
                                                "Cancelled";
                                            CollectionReference users =
                                                FirebaseFirestore.instance
                                                    .collection('USER ORDER');

                                            users
                                                .doc(uid)
                                                .update(
                                                    {'User Order': user_order})
                                                .then((value) => Toast.show(
                                                    "Order Cancelled", context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor:
                                                        Colors.grey[300],
                                                    textColor: Colors.black))
                                                .catchError((error) => Toast.show(
                                                    "Error in Cancelling an order: $error",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.BOTTOM,
                                                    backgroundColor:
                                                        Colors.grey[300],
                                                    textColor: Colors.black));
                                            readOrder(); ////////////USER ORDER////////
                                            CollectionReference order =
                                                FirebaseFirestore.instance
                                                    .collection('ORDER');

                                            order
                                                .doc(
                                                    '${user_order[index]['Order Number']}')
                                                .update({'Order': user_order});
                                          },
                                          text: 'CANCEL ORDER',
                                          shape: GFButtonShape.square,
                                          type: GFButtonType.outline2x,
                                          size: GFSize.LARGE,
                                          color: Colors.black,
                                        ),
                                      Divider(),
                                    ]));
                              })
                        ]),
                    Padding(padding: EdgeInsets.all(10.0)),
                    Divider(thickness: 2),
                  ])));
            }));
  }
}
