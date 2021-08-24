import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({Key? key, required this.pass}) : super(key: key);

  String pass;

  //instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //define  controller variables
  TextEditingController nameController = TextEditingController()..value;
  TextEditingController ageController = TextEditingController()..value;
  TextEditingController emailController = TextEditingController()..value;

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
        title: Text('Update Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text('docID : $pass'),
              TextField(
                controller: nameController,
              ),
              TextField(
                controller: ageController,
              ),
              TextField(
                controller: emailController,
              ),
              ElevatedButton(
                onPressed: () {
                  updateUser(pass, nameController.text, ageController.text,
                      emailController.text);
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
