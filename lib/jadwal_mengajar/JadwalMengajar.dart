import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_siakad/jadwal_mengajar/JadwalMengajarDanBimbingan.dart';
import 'package:project_siakad/jadwal_mengajar/TaskList.dart';

class JadwalMengajar extends StatefulWidget {
  @override
  _JadwalMengajarState createState() => _JadwalMengajarState();
}

class _JadwalMengajarState extends State<JadwalMengajar> {
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            Route route = MaterialPageRoute(
                builder: (context) =>
                    JadwalMengajarDanBimbingan(options: "jadwalmengajar"));
            Navigator.push(context, route);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 20.0,
          color: Colors.blueGrey,
          child: ButtonBar(
            children: [],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Jadwal Mengajar"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("jadwalmengajar")
                  .where("uid", isEqualTo: user.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TaskList(
                    document: snapshot.data.docs,
                    options: "jadwalmengajar",
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
