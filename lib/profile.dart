import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseStorage storage = FirebaseStorage.instance;

  String? imageUrl;

  Future<void> uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;

    final _imagePicker = ImagePicker();
    var pickedImage;

    print('Should Open Picker');

    //Select Image
    pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);
    var file = File(pickedImage.path);

    if (pickedImage != null) {
      //Upload to Firebase Storage
      var snapshot =
          await _firebaseStorage.ref().child('profilepix').putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
      print('done Picker and uploaded to firebase');
    } else {
      print('No Image Path Received');
    }
  }

  @override
  Widget build(BuildContext context) {

    final firebaseUser = context.watch<User?>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: 
                [
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.all(15),
                    
                    child: (imageUrl != null)
                        ? Image.network(imageUrl!)
                        : Image.network('https://i.imgur.com/sUFH1Aq.png')),
                  Positioned(
                    bottom: 30,
                    right: 50,
                    child: ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Text('Take photo')),
                  ),
                ],   
              ),
              Text(imageUrl.toString()),
              Text(firebaseUser!.uid.toString()),
              Text(firebaseUser.email.toString()),
              
            ],
          ),
        ),
      ),
    );
  }
}
