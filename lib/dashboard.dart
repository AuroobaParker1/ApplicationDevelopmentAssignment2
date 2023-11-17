// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Students').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return Expanded(
                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.0),
                        child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.white,
                              elevation: 2.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 1.0, bottom: 1.0),
                                  child: ListTile(
                                    leading: Image.network(
                                        data['Image'].toString(),
                                        fit: BoxFit.contain),
                                    title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                            data['Name'].toString())),
                                    trailing: Text(
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        data['Course'].toString()),
                                  )),
                            )));
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
