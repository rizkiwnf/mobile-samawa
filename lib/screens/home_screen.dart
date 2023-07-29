import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_samawa/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  // instance firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
        foregroundColor: Colors.white,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: Icon(Icons.logout),
            label: Text("Sign Out"),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  // masuk ke firestore pake collection users
                  CollectionReference users = firestore.collection('users');
                  // id nama random
                  // await users.add({'name': 'rizki'});
                  // id nama ditentukan
                  await users.doc("flutter123").set({'name': "google FLutter"});
                },
                child: Text("Add Data to FireStore")),
          ],
        ),
      ),
    );
  }
}
