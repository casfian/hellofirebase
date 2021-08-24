import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellofirebase/updatepage.dart';

class Display extends StatelessWidget {
  //instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //delete
  void delete(String docID) async {
    try {
      await firestore.collection('users').doc(docID).delete();
    } catch (e) {
      print(e);
    }
  }

  //update
  void updateUser(String docID, String name, String age, String email) async {
    try {
      await firestore
          .collection('users')
          .doc(docID)
          .update({'age': age, 'name': name, 'email': email});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          initialData: null, //data awal kita
          stream: FirebaseFirestore.instance
              .collection('users')
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
                  leading: Icon(Icons.person),
                  title: Text(data['name']),
                  //subtitle: Text(document.id.toString()),
                  subtitle: Text(data['email']),
                  trailing: IconButton(
                    onPressed: () {
                      //pergi page Update
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()  ) );
                    },
                    icon: Icon(Icons.edit),
                  ),
                );
              }).toList(),
            );
          } //paparkan data kita
          ),
    );
  }
}
