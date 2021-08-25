import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hellofirebase/display.dart';
import 'package:hellofirebase/login.dart';
import 'authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: Authenticate(),
      ),
    );
  }
}

//class ne utk check dia dah login atau tak
class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    // kalau user ada (user bukan kosong aka null) maka maksudnya dah login
    if (firebaseUser != null) {
      return Home(); //dan kita suruh dia gi page Home
    }
    // kalau tak suruh dia login
    return Login();
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
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email:',
                  border: OutlineInputBorder(),
                ),
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
                child: Text('Display Data'),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<AuthenticationProvider>().signOut();
                },
                child: Text('Logout!'),
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
