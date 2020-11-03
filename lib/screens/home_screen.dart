import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project_mpsp/database/firebase_utils.dart';
import 'package:project_mpsp/models/user_model.dart';

import 'package:project_mpsp/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User firebaseUser;

  getData() {
    firebaseUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await FirebaseUtils.removeFirebaseToken();
                FirebaseAuth.instance.signOut().then((onValue) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                });
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          'https://static.thenounproject.com/png/629576-200.png',
                          width: 100,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Query getQuery() {
  Query query = FirebaseFirestore.instance
      .collection(Constants.statues)
      .where("docid", isEqualTo: "MmuEd2wRd4V1Q6mu1Ryz");
  return query;
}

class PostTile extends StatelessWidget {
  final UserModel userModel;
  PostTile({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          userModel.cpf,
          height: 100,
          width: 100,
        ),
        title: Text(
          userModel.email,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          userModel.timestamp.toDate().toString().split(" ")[0],
          maxLines: 2,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: Text("${userModel.nome} "),
      ),
    );
  }
}
