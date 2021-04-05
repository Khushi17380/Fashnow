import 'package:flutter/material.dart';

class TermsAndCondition extends StatefulWidget {
  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            //centerTitle: true,
            title: Text(
              'Terms & Condition',
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
              Padding(padding: EdgeInsets.all(15.0)),
              Center(
                child: Text("FASHNOW:",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700])),
              ),
              Center(
                child: Text("TERMS AND CONDITION",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700])),
              ),
              Padding(padding: EdgeInsets.all(30.0)),
              Center(
                  child: ListTile(
                      title: Text(
                          "Welcome to Fashnow.This document is an electronic record in terms of Information Technology Act, 2000 and published in accordance with the provisions of Rule 3 ) of the Information Technology (Intermediaries guidelines) Rules, 2011 that require publishing the rules and regulations, privacy policy and Terms of Use for access or usage of Fashnow marketplace platform\n\nWhen You use any of the services provided by Us through the Platform, including but not limited to, (e.g. Product Reviews, Seller Reviews), You will be subject to the rules, guidelines, policies, terms, and conditions applicable to such service, and they shall be deemed to be incorporated into this Terms of Use and shall be considered as part and parcel of this Terms of Use. We reserve the right, at Our sole discretion, to change, modify, add or remove portions of these Terms of Use, at any time without any prior written notice to You. You shall ensure to review these Terms of Use periodically for updates/changes. Your continued use of the Platform following the posting of changes will mean that You accept and agree to the revisions. As long as You comply with these Terms of Use, We grant You a personal, non-exclusive, non-transferable, limited privilege to enter and use the Platform. By impliedly or expressly accepting these Terms of Use, You also accept and agree to be bound by Fashnow Policies including but not limited to Privacy Policy as amended from time to time.",
                          style: TextStyle(color: Colors.grey, fontSize: 13)))),
              Padding(padding: EdgeInsets.all(20.0)),
              ExpansionTile(
                  title: Text(
                    "1. User Account, Password an Security",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          "If You use the Platform, You shall be responsible for maintaining the confidentiality of your Display Name and Password and You shall be responsible for all activities that occur under your Display Name and Password. You agree that if You provide any information that is untrue, inaccurate, not current or incomplete, We shall have the right to indefinitely suspend or terminate or block access of your membership on the Platform.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600)),
                    )
                  ]),
              ExpansionTile(
                  title: Text(
                    "2. Service Offered",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                          "Fashnow provides a number of Internet-based services through the Platform. One such Service enables Users to purchase original merchandise such as clothing, footwear and accessories from various fashion and lifestyle brands (collectively, 'Products'). The Products can be purchased through the Platform through various methods of payments offered. The sale/purchase of Products shall be additionally governed by specific policies of sale, like cancellation policy, exchange policy, return policy, etc. It is clarified that at the time of creating a return request, users are required to confirm (via a check box click) that the product being returned is unused and has the original tags intact. If the product returned by the user is used, damaged or if the original tags are missing, the user’s return request shall be declined, and the said product shall be re-shipped back to the customer. In the event that the return request is declined, the user shall not be eligible for a refund, and Fashnow assumes no liability in this regard. Further, in the event that the user fails to accept the receipt of the said re-shipped product, the user shall continue to be not eligible for a refund, and Fashnow assumes no liability with respect to the return or refund for the said re-shipped product. In addition, these Terms of Use may be further supplemented by Product specific conditions, which may be displayed with that Product.\n\nFashnow does not warrant that Product description or other content on the Platform is accurate, complete, reliable, current, or error-free and assumes no liability in this regard.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600)),
                    )
                  ]),
              Padding(padding: EdgeInsets.all(30.0)),
            ])));
  }
}
