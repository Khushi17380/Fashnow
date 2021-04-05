import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/my_orders/order&cartview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:toast/toast.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;
CollectionReference usercart =
    FirebaseFirestore.instance.collection('USER WISHLIST');

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<Map<dynamic, dynamic>> values = [];
  Future<void> readWishlistData() async {
    // ignore: deprecated_member_use
    var query = Firestore.instance.collection('USER WISHLIST').document(uid);
    query.snapshots().forEach((doc) {
      setState(() {
        values = List.from(doc.data()['Wishlist']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    readWishlistData();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Wishlist',
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
                  color: Colors.red[100],
                  title: GFListTile(
                    avatar: GFAvatar(
                        backgroundImage:
                            NetworkImage(values[index]['Wishlist_Image1']),
                        shape: GFAvatarShape.standard),
                    title: Text(values[index]['Wishlist_Name'],
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w600)),
                    subTitle: Text(values[index]['Wishlist_Cost']),
                  ),
                  content: Text('Size: ${values[index]['Wishlist_Size']}'),
                  buttonBar: GFButtonBar(
                    children: <Widget>[
                      GFButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ignore: missing_required_param
                                builder: (context) => OPpg(
                                  db: '${values[index]['Wishlist_Db']}',
                                  product_code:
                                      '${values[index]['Wishlist_Product_Code']}',
                                ),
                              ));
                        },
                        text: 'View',
                        type: GFButtonType.transparent,
                        size: GFSize.LARGE,
                      ),
                      GFButton(
                        ////To remove item from wishlist/////////////////
                        onPressed: () {
                          usercart
                              .doc(uid)
                              .update({
                                'Wishlist':
                                    FieldValue.arrayRemove([values[index]])
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
                          readWishlistData();
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
    );
  }
}
