import 'package:flutter/material.dart';
import 'package:hellofirebase/register.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';

class Login extends StatelessWidget {
  //declare
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Selamat Datang. Sila Register dulu, Baru Login'),
              SizedBox(height: 20,),
              Image.network('http://3.bp.blogspot.com/-XDgd6SAzXv4/TmyGaFgy87I/AAAAAAAAAa4/uz3lxjvkQFk/s640/836454644.jpg'),
              SizedBox(height: 20,),
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password:',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      //signIn function sini
                      context.read<AuthenticationProvider>().signIn(
                          email: emailController.text,
                          password: passwordController.text);
                      
                    },
                    child: Text('Login')),
              ),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text('Register')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
