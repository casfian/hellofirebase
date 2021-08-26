import 'package:flutter/material.dart';
import 'package:hellofirebase/createproduct.dart';

class SenaraiProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Container(
          child: Text('nanti guna Stream Builder utk create senarai'),
        ),
      ),
    );
  }
}
