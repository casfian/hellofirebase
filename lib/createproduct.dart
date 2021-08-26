import 'package:flutter/material.dart';
 
class CreateProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create product'),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [

                TextField(),
                TextField(),
                TextField(),
                ElevatedButton(
                  onPressed: () {

                }, 
                child: Text('Create product')
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}