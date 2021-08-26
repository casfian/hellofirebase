import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hellofirebase/model/product.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateProduct extends StatelessWidget {
  //declare
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final photoController = TextEditingController();
  var created;

  //1. buat instance of Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> createProduct(String nama, String harga, String photo, String created) async {
    
    //step 1: Create Product
    Product(nama, harga, photo, created);
    print(Product(nama, harga, photo, created));

    //step 2: Guna Firebase dan save
    try {
      await firestore
          .collection('products')
          .doc()
          .set({'nama': nama, 
          'harga': harga, 
          'photo': photo, 
          'created': created});
      print('add product to firebase database');
    } catch (e) {
      print(e);
    }


  }

  @override
  Widget build(BuildContext context) {
    //Authentication provider variable
    //ne kegunaan Provider, blh passing parameter
    final firebaseUser = context.read<User?>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create product'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(firebaseUser!.uid.toString()),
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
                    created = firebaseUser.uid.toString();
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
