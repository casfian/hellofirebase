import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hellofirebase/createproduct.dart';
import 'package:provider/provider.dart';

class SenaraiProduct extends StatelessWidget {
  //1. buat instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.read<User?>();
    var querycreated = firebaseUser!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Senarai product'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateProduct()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          initialData: null, //data awal kita
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('created',
                  isEqualTo: querycreated) //kita nak query data berdasarkan created
              .snapshots(), //sumber data kita
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return ListTile(
                  leading: Text(data['photo']),
                  title: Text(data['nama']),
                  //subtitle: Text(document.id.toString()),
                  subtitle: Text('RM${data['harga']}'),
                );
              }).toList(),
            );
          } //paparkan data kita
          ),
    );
  }
}
