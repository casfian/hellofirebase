import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  //decalre
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email:',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password:',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  //signUp function sini
                  context.read<AuthenticationProvider>().signUp(
                      email: emailController.text,
                      password: passwordController.text);
                  Navigator.pop(context);
                },
                child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
