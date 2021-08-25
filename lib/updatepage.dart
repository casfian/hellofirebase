import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellofirebase/user.dart'; //import user class

class UpdatePage extends StatefulWidget {
  UpdatePage({Key? key, required this.pass}) : super(key: key);

  final User pass; //tukar ke User

  

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    
    //declare dan masuk value pass ke dalamnya
    TextEditingController nameController = TextEditingController()..text = widget.pass.name;
    TextEditingController ageController = TextEditingController()..text = widget.pass.age;
    TextEditingController emailController = TextEditingController()..text = widget.pass.email;
    //----

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [

              Text('docID : ${widget.pass.docID}'), //tambah code ne

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
                  //tambah code ne utk update data
                  updateUser(widget.pass.docID, nameController.text,
                      ageController.text, emailController.text);
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
