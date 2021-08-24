import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellofirebase/display.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  //1. buat instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //2. Create function Create.
  //   note: private function kita guna "_"
  void _createUser() async {
    try {
      await firestore
          .collection('users')
          .doc()
          .set({'name': 'Ali', 'age': '16', 'email': 'ali@gmail.com'});
      print('add user');
    } catch (e) {
      print(e);
    }
  }

  //3. Update data
  void _updateUser() async {
    try {
      await firestore
          .collection('users')
          .doc('testuser')
          .update({'age': '40', 'name': 'Ahmad'});
    } catch (e) {
      print(e);
    }
  }

  //4. Read data
  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testuser').get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  //5. Delete data
  void _delete() async {
    try {
      await firestore.collection('users').doc('testuser').delete();
    } catch (e) {
      print(e);
    }
  }

  //define  controller variables
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void _create(String name, String age, String email) async {
    try {
      await firestore
          .collection('users')
          .doc()
          .set({'name': name, 'age': age, 'email': email});
      print('add user');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD Demo'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
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
                    _create(nameController.text, ageController.text,
                        emailController.text);
                  },
                  child: Text('Create New data')),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Display()));
                },
                child: Text('Display'),
              ),

              // ElevatedButton(
              //   onPressed: _createUser,
              //   child: Text('Create'),
              // ),
              // ElevatedButton(
              //   onPressed: _read,
              //   child: Text('Read'),
              // ),
              // ElevatedButton(
              //   onPressed: _updateUser,
              //   child: Text('Update'),
              // ),
              // ElevatedButton(
              //   onPressed: _delete,
              //   child: Text('Delete'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
