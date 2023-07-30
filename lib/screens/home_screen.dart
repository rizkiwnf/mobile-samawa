import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_samawa/screens/add_note.dart';
import 'package:mobile_samawa/screens/register_screen.dart';
import 'package:mobile_samawa/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // instance firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // get current user
    final user = firebaseAuth.currentUser!;
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
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                  (route) => false);
            },
            icon: Icon(Icons.logout),
            label: Text("Sign Out"),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // show display name current user
          Center(
            child: Text("Hello " + user.displayName!),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen()));
        },
      ),
    );
  }
}

// after body => CRUD

// Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   // masuk ke firestore pake collection users
//                   CollectionReference users = firestore.collection('users');
//                   // id nama random
//                   // await users.add({'name': 'rizki'});
//                   // id nama ditentukan
//                   await users.doc("flutter123").set({'name': "google FLutter"});
//                 },
//                 child: Text("Add Data to FireStore")),
//             ElevatedButton(
//                 onPressed: () async {
//                   // get data di collection users, all data
//                   CollectionReference users = firestore.collection('users');
//                   // QuerySnapshot allResults = await users.get();
//                   // allResults.docs.forEach((DocumentSnapshot result) {
//                   //   print(result.data());
//                   // }

//                   // get data users dengan nama flutter123
//                   DocumentSnapshot result = await users.doc('flutter123').get();
//                   print(result.data());

//                   // get data setiap ada perubahan akan terlihat historynya
//                   // users.doc("flutter123").snapshots().listen((result) {
//                   //   print(result.data());
//                   // });
//                 },
//                 child: Text("Get Data to FireStore")),
//             ElevatedButton(
//                 onPressed: () async {
//                   await firestore
//                       .collection('users')
//                       .doc("flutter123")
//                       .update({'name': "Flutter Firebase"});
//                 },
//                 child: Text("Update Data in FireStore")),
//             ElevatedButton(
//                 onPressed: () async {
//                   await firestore
//                       .collection('users')
//                       .doc("flutter123")
//                       .delete();
//                 },
//                 child: Text("Delete Data in FireStore")),
//           ],
//         ),
//       ),
