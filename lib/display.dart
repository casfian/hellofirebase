import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Display extends StatelessWidget {
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
                  title: Text(data['name']),
                  subtitle: Text(data['email']),
                  trailing: Text(data['age']),
                );
              }).toList(),
            );
          } //paparkan data kita
          ),
    );
  }
}
