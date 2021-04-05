import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashnow_/PRODUCTS/productgrid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> recentSearches = new List();
List<String> searches = new List();

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;
final uid = user.uid;
// ignore: non_constant_identifier_names
CollectionReference user_r_searches =
    FirebaseFirestore.instance.collection('USER RECENT SEARCHES');

getsuggestion() async {
  // ignore: deprecated_member_use
  await Firestore.instance
      .collection('suggestion list')
      // ignore: deprecated_member_use
      .document('suggestion list')
      .get()
      .then((value) {
    List.from(value.data()['suggestions']).forEach((element) {
      String data = element;
      searches.add(data);
      searches = searches.toSet().toList();
    });
  });
}

getrsearches() async {
  // ignore: deprecated_member_use
  await Firestore.instance
      .collection('USER RECENT SEARCHES')
      // ignore: deprecated_member_use
      .document(uid)
      .get()
      .then((value) {
    List.from(value.data()['Recent Searches']).forEach((element) {
      String data = element;
      recentSearches.insert(0, data);
      recentSearches = recentSearches.toSet().toList();
    });
  });
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Pgrid(db: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /////////////RECENT SEARCH//////////////
    if (query.isEmpty) {
      getrsearches();
      var suggestionList = recentSearches;
      return ListView.builder(
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            query = recentSearches[index];
            showResults(context);
          },
          leading: Icon(Icons.history),
          title: Text(recentSearches[index]),
        ),
        itemCount: suggestionList.length,
      );
    }
    //////////////SUGGESTIONS///////////////
    else {
      getsuggestion();
      final suggestionList = searches
          .where((p) => p.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return suggestionList.isEmpty
          ? Text("No Result Found...", style: TextStyle(fontSize: 20))
          : ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  query = suggestionList[index];
                  ///////////////////////////////////////////////
                  user_r_searches
                      .doc(uid)
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      ///////////to check document exists or not
                      ///exits
                      user_r_searches.doc(uid).update({
                        'Recent Searches': FieldValue.arrayUnion([query]),
                      }); //////////USER CART///////
                    } else {
                      ////not exit
                      user_r_searches.doc(uid).set({
                        'Recent Searches': FieldValue.arrayUnion([query]),
                      }); //////////USER RECENT SEARCHES///////
                    }
                  });
                  showResults(context);
                },
                leading: Icon(Icons.search),
                title: RichText(
                    text: TextSpan(
                  text: suggestionList[index].substring(
                      0,
                      suggestionList[index]
                          .toLowerCase()
                          .indexOf(query.toLowerCase())),
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: suggestionList[index].substring(
                          suggestionList[index]
                              .toLowerCase()
                              .indexOf(query.toLowerCase()),
                          suggestionList[index]
                                  .toLowerCase()
                                  .indexOf(query.toLowerCase()) +
                              query.toLowerCase().length),
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: suggestionList[index].substring(
                          suggestionList[index]
                                  .toLowerCase()
                                  .indexOf(query.toLowerCase()) +
                              query.toLowerCase().length,
                          suggestionList[index].toLowerCase().length),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
              ),
              itemCount: suggestionList.length,
            );
    }
  }
}
