import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hellofirebase/model/product.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends StatefulWidget {
  //declare
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  

  var created;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createProduct(
      String nama, String harga, String photo, String created) async {
    //step 1: Create Product
    Product(nama, harga, photo, created);
    print(Product(nama, harga, photo, created));

    //step 2: Guna Firebase dan save
    try {
      await firestore.collection('products').doc().set(
          {'nama': nama, 'harga': harga, 'photo': photo, 'created': created});
      print('add product to firebase database');
    } catch (e) {
      print(e);
    }
  }

  //buat instance utk guna
    final firebaseStorage = FirebaseStorage.instance;

    var imageUrl;

    //create 1 function utk upload gambar
    void uploadPhoto() async {
      //1. buka Picker utk guna camera
      //declare variable utk picker
      final _imagePicker = ImagePicker();
      var pickedImage;

      //Select Image
      pickedImage = await _imagePicker.pickImage(source: ImageSource.camera);

      //2. dah dapat gambar URL save kat firebase storage
      var file = File(pickedImage.path);

      if (pickedImage != null) {
        //3. jgn lupa ambil url gambar dan save kat firebase database
        //Upload to Firebase Storage
        var snapshot =
            await firebaseStorage.ref().child('productpix').putFile(file);

        //ne utk dapat kan url gambar save kat firebase storage
        var downloadUrl = await snapshot.ref.getDownloadURL();

        print(downloadUrl);

        //guna setstate supaya update screen
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
    //Authentication provider variable
    //ne kegunaan Provider, blh passing parameter
    final firebaseUser = context.read<User?>();

    final namaController = TextEditingController();
  final hargaController = TextEditingController();
  TextEditingController  photoController = TextEditingController()..text = imageUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(imageUrl.toString()),
              SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  //Kalau imageUrl tak kosong maka papar gambar
                  //kalau kosong papar placeholder url
                  Container(
                    child: (imageUrl != null)
                        ? Image.network(imageUrl!)
                        : Image.network('https://i.imgur.com/sUFH1Aq.png'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //code
                        uploadPhoto();
                      },
                      child: Text('Upload Gambar')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: hargaController,
                decoration: InputDecoration(
                  labelText: 'Harga:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: photoController,
                decoration: InputDecoration(
                  labelText: 'Photo:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    print('I click');
                    created = firebaseUser!.uid.toString();
                    createProduct(namaController.text, hargaController.text,
                        photoController.text, created);
                  },
                  child: Text('Create product')),
            ],
          ),
        ),
      ),
    );
  }
}
